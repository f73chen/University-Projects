import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np
from math import exp
from tqdm import tqdm
import time

from option_critic import OptionCriticFeatures
from replay_buffer import ReplayBuffer
from utils import actor_loss_aoc, critic_loss_oc
from logger import AOCLogger

class AOCFeatures(OptionCriticFeatures):
    def __init__(self,
                 env,
                 num_options,
                 device="cpu",
                 
                 temperature=1.0,
                 epsilon_start=1.0,
                 epsilon_min=0.1,
                 epsilon_decay=int(1e6),
                 gamma=0.95,
                 tau=1.0,
                 
                 termination_reg=0.01,
                 entropy_reg=0.01,
                 diversity_reg=1.0,  # AOC only
                 sparsity_reg=1.0,   # AOC only
                 smoothness_reg=1.0, # AOC only
                 
                 hidden_size=32,
                 state_size=64,
                 
                 learning_rate=1e-4,
                 batch_size=64,
                 critic_freq=10,
                 target_update_freq=50,
                 buffer_size=10000,
                 
                 tensorboard_log=None,
                 verbose=0,
                 testing=False,
                 is_policy_network=True) -> None:
        super(AOCFeatures, self).__init__(env, num_options, device,
                                          temperature, epsilon_start, epsilon_min, epsilon_decay, gamma, tau,
                                          termination_reg, entropy_reg,
                                          hidden_size, state_size,
                                          learning_rate, batch_size, critic_freq, target_update_freq, buffer_size,
                                          tensorboard_log, verbose, testing, is_policy_network=False)
        
        # AOC regularization weights
        self.diversity_reg = diversity_reg
        self.sparsity_reg = sparsity_reg
        self.smoothness_reg = smoothness_reg
        
        # Learnable attention mask
        self.attention = nn.ModuleList([
            nn.Sequential(
                nn.Linear(self.in_features, self.in_features),
                nn.Sigmoid()
            ) for _ in range(num_options)
        ])
        
        # Target network
        if is_policy_network:
            self.target_network = AOCFeatures(env, num_options, device,
                                              temperature, epsilon_start, epsilon_min, epsilon_decay, gamma, tau,
                                              termination_reg, entropy_reg, diversity_reg, sparsity_reg, smoothness_reg,
                                              hidden_size, state_size,
                                              learning_rate, batch_size, critic_freq, target_update_freq, buffer_size,
                                              tensorboard_log, verbose, testing, is_policy_network=False)
            self.update_target_network()
        else:
            self.target_network = None

        self.to(device)

    # TODO: Verify
    def apply_attention(self, obs, option):
        obs_tensor = torch.tensor(obs, dtype=torch.float32).to(self.device).reshape(1, -1)
        attention_mask = self.attention[option](obs_tensor)
        return attention_mask * obs_tensor, attention_mask

    # Use the AOC actor loss and log attention metrics
    def learn(self, total_timesteps) -> None:
        obs, _ = self.env.reset()
        episode_idx = 0
        episode_reward = 0
        episode_length = 0
        option_lengths = {opt: [] for opt in range(self.num_options)}
        option = None
        curr_option_length = 0
        option_termination = True
        replay_buffer = ReplayBuffer(capacity=self.buffer_size)
        optimizer = torch.optim.AdamW(self.parameters(), lr=self.learning_rate)
        
        if self.tensorboard_log is not None:
            logger = AOCLogger(logdir=self.tensorboard_log, run_name=f"OC-{time.time()}")
        
        for step in tqdm(range(total_timesteps)):
            # Choose an option and action using epsilon-greedy
            epsilon = self.epsilon_min + (self.epsilon_start - self.epsilon_min) * exp(-step / self.epsilon_decay)
            option, action, logp, entropy = self.predict(obs, option, option_termination, epsilon)
            
            # Take a step in the environment
            next_obs, reward, done, truncated, _ = self.env.step(action)
            replay_buffer.add(obs, option, reward, next_obs, done)
            
            # Sample whether the current option terminates in the next step
            option_termination = self.get_option_termination(next_obs, option)
            
            # Iterate episodic variables
            obs = next_obs
            episode_reward += reward
            episode_length += 1
            curr_option_length += 1
            
            # Record option lengths
            if option_termination:
                option_lengths[option].append(curr_option_length)
                curr_option_length = 0
            
            # Reset environment if done or truncated
            if done or truncated:
                if self.verbose == 1:
                    print(f"Episode {episode_idx} finished with reward: {episode_reward}, epsilon:{epsilon}")
                
                # Terminate the option if the episode ends
                if not option_termination:
                    option_lengths[option].append(curr_option_length)
                    curr_option_length = 0
                
                # Log and reset episodic variables
                if self.tensorboard_log is not None:
                    logger.log_episode(episode_idx, episode_reward, episode_length, option_lengths)
                obs, _ = self.env.reset()
                episode_idx += 1
                episode_reward = 0
                episode_length = 0
                option_lengths = {opt: [] for opt in range(self.num_options)}
                option_termination = True
                
            # Sample from buffer and backprop the loss
            actor_loss_value = None
            diversity_loss = None
            sparsity_loss = None
            smoothness_loss = None
            critic_loss_value = None
            if len(replay_buffer) >= self.batch_size:
                # Update the actor loss every step
                # Note: Diversity, sparsity, and smoothness are just for logging. They're already included in the actor loss
                actor_loss_value, diversity_loss, sparsity_loss, smoothness_loss = actor_loss_aoc(self, self.target_network, obs, option, reward, next_obs, done, logp, entropy)
                loss = actor_loss_value
                
                # Update the critic loss every critic_freq steps
                if step % self.critic_freq == 0:
                    batch = replay_buffer.sample(self.batch_size)
                    critic_loss_value = critic_loss_oc(self, self.target_network, batch)
                    loss += critic_loss_value
                
                # Optimization step
                optimizer.zero_grad()
                loss.backward()
                optimizer.step()
                
            # Update the target network every few steps
            if step % self.target_update_freq == 0:
                self.update_target_network()
                
            if self.tensorboard_log is not None:
                logger.log_step(step, actor_loss_value, critic_loss_value, entropy.item(), epsilon, diversity_loss, sparsity_loss, smoothness_loss)
    
    # Helper: Return the option index with the highest Q-value given attention
    def greedy_option(self, obs):
        # Get the attended states for each option
        Qs = []
        for option in range(self.num_options):
            attended_obs, _ = self.apply_attention(obs, option)
            state = self.features(attended_obs)
            
            # If applying the ith option's attention mask, get the ith option's Q value
            Q_Omega = self.Q(state)[:, option]
            Qs.append(Q_Omega.item())
        
        # Return the option with the highest Q_Omega value
        return np.array(Qs).argmax()

    def predict(self, obs, option, option_termination, epsilon=1.0, deterministic=False):
        # Choose a new option if the previous one terminates
        if option_termination:
            if deterministic or np.random.random() > epsilon:
                option = self.greedy_option(obs)
            else:
                option = np.random.randint(0, self.num_options)

        # Choose an action based on the chosen option
        attended_obs, _ = self.apply_attention(obs, option)
        state = self.features(attended_obs)
        action, logp, entropy = self.get_action(state, option)

        return option, action, logp, entropy

    # Helper: Attentions between different options should be distinct
    def get_diversity_loss(self):
        attention_masks = [att[0].weight for att in self.attention]
        total_similarity = 0
        # Get the total cosine similarity between every pair of option attentions
        for i in range(len(attention_masks)):
            for j in range(i + 1, len(attention_masks)):
                total_similarity += F.cosine_similarity(attention_masks[i], attention_masks[j]).mean()
        return self.diversity_reg * total_similarity

    # Helper: Attention weights should be as small as possible
    def get_sparsity_loss(self):
        sparsity_loss = 0
        for att in self.attention:
            sparsity_loss += att[0].weight.abs().sum()
        return self.sparsity_reg * sparsity_loss

    # Helper: Attentions for the same option should be consistent across a trajectory
    def get_smoothness_loss(self, attention_mask, next_attention_mask):
        similarity = F.cosine_similarity(attention_mask, next_attention_mask).mean()
        return self.smoothness_reg * (1 - similarity)
        
