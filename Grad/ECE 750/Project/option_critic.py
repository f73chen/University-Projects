import torch
import torch.nn as nn
from torch.distributions import Categorical, Bernoulli
import numpy as np
from copy import deepcopy
from math import exp
import time

from replay_buffer import ReplayBuffer
from utils import actor_loss, critic_loss
from logger import Logger

# Flattens observations
# Outputs a discrete action index
class OptionCriticFeatures(nn.Module):
    # TODO: Add tensorboard_log
    def __init__(self,
                 env,
                 num_options,
                 device="cpu",
                 temperature=1.0,
                 epsilon_start=1.0,
                 epsilon_min=0.1,
                 epsilon_decay=int(1e6),
                 gamma=0.95,
                 termination_reg=0.01,
                 entropy_reg = 0.01,
                 learning_rate=1e-4,
                 batch_size=64,
                 critic_freq=10,
                 target_update_freq=50,
                 buffer_size=10000,
                 tensorboard_log=None,
                 verbose=1,
                 is_policy_network=True) -> None:
        super(OptionCriticFeatures, self).__init__()
        
        self.env = env
        obs_shape = env.observation_space.shape
        flattened_obs = np.prod(obs_shape)
        self.in_features = flattened_obs
        self.num_actions = env.action_space.n
        
        self.num_options = num_options
        self.device = device
        
        self.temperature = temperature
        self.epsilon_start = epsilon_start
        self.epsilon_min = epsilon_min
        self.epsilon_decay = epsilon_decay
        self.gamma = gamma
        self.termination_reg = termination_reg
        self.entropy_reg = entropy_reg
        
        self.learning_rate = learning_rate
        self.batch_size = batch_size
        self.critic_freq = critic_freq
        self.target_update_freq = target_update_freq
        self.buffer_size = buffer_size
        
        self.tensorboard_log = tensorboard_log
        self.verbose = verbose
        
        # Shared network
        self.features = nn.Sequential(
            nn.Linear(self.in_features, 32),
            nn.ReLU(),
            nn.Linear(32, 64),
            nn.ReLU()
        )
        
        # Q_Omega head
        self.Q = nn.Linear(64, num_options)
        
        # beta_w head
        self.terminations = nn.Linear(64, num_options)
        
        # pi_w head weights and biases
        self.options_W = nn.Parameter(torch.empty(num_options, 64, self.num_actions, device=device))
        torch.nn.init.xavier_uniform_(self.options_W)   # Make weights non-zero
        self.options_b = nn.Parameter(torch.zeros(num_options, self.num_actions, device=device))
        
        self.to(device)
        
        # Initialize target network and copy over the parameters
        # Only create the target network if self is policy network to avoid infinite recursion
        if is_policy_network:
            self.target_network = OptionCriticFeatures(env, num_options, is_policy_network=False)
            self.update_target_network()
        else:
            self.target_network = None
        
    # Tau = 1.0 --> Hard copy, completely replace target network with policy network
    # Tau = 0.01 --> Soft update, gradually shift target network in the direction of policy network
    def update_target_network(self, tau=1.0):
        with torch.no_grad():
            for target_param, param in zip(self.target_network.parameters(), self.parameters()):
                target_param.data.copy_(tau * param.data + (1.0 - tau) * target_param.data)
                
    # Calculate whether the current option should terminate
    def get_option_termination(self, obs, option):
        obs_tensor = torch.tensor(obs, dtype=torch.float32).reshape(1, -1).to(self.device)
        state = self.features(obs_tensor)
        termination = self.terminations(state)[:, option].sigmoid()
        termination = Bernoulli(termination).sample()
        return bool(termination.item())
        
    # Learn by interacting with the environment
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
            logger = Logger(logdir=self.tensorboard_log, run_name=f"OC-{time.time()}")
        
        for step in range(total_timesteps):
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
                    logger.log_episode(episode_idx, episode_reward, episode_length, option_lengths)    # TODO
                obs, _ = self.env.reset()
                episode_idx += 1
                episode_reward = 0
                episode_length = 0
                option_lengths = {opt: [] for opt in range(self.num_options)}
                option_termination = True
                
            # Sample from buffer and backprop the loss
            actor_loss_value = None
            critic_loss_value = None
            if len(replay_buffer) >= self.batch_size:
                # Update the actor loss every step
                actor_loss_value = actor_loss(self, self.target_network, obs, option, reward, next_obs, done, logp, entropy)
                loss = actor_loss_value
                
                # Update the critic loss every critic_freq steps
                if step % self.critic_freq == 0:
                    batch = replay_buffer.sample(self.batch_size)
                    critic_loss_value = critic_loss(self, self.target_network, batch)
                    loss += critic_loss_value
                
                # Optimization step
                optimizer.zero_grad()
                loss.backward()
                optimizer.step()
                
            # Update the target network every few steps
            if step % self.target_update_freq == 0:
                self.update_target_network()
                
            if self.tensorboard_log is not None:
                logger.log_step(step, actor_loss_value, critic_loss_value, entropy.item(), epsilon)   # TODO
    
    # Helper: Return the option index with the highest Q_Omega value
    def greedy_option(self, state):
        Q_Omegas = self.Q(state)
        return Q_Omegas.argmax(dim=-1).item()
    
    # Helper: Selects an action based on the state and option
    def get_action(self, state, option):
        # logits = state * weights + biases (unnormalized action scores for that option)
        logits = state.data @ self.options_W[option] + self.options_b[option]
        
        # Convert logits to softmax probabilities (sums to 1)
        action_dist = (logits / self.temperature).softmax(dim=-1)
        
        # Probability wrapper (adds functionality)
        action_dist = Categorical(action_dist)
        
        # Chooses an action based on the probabilites
        action = action_dist.sample()
        logp = action_dist.log_prob(action)
        entropy = action_dist.entropy()
        
        return action.item(), logp, entropy
    
    # Selects an action based on the observations
    def predict(self, obs, option, option_termination, epsilon=1.0, deterministic=False) -> int:
        # Flatten the observations to 1D and add a batch dimension
        obs_tensor = torch.tensor(obs, dtype=torch.float32).reshape(1, -1).to(self.device)
        
        # Get the output of the shared network
        state = self.features(obs_tensor)
        
        # Only choose a new option if the previous one terminates, else continue with the current option
        if option_termination:
            if deterministic or np.random.random() > epsilon:
                option = self.greedy_option(state)
            else:
                option = np.random.randint(0, self.num_options)
        
        # Choose an action based on the option
        action, logp, entropy = self.get_action(state, option)
        return option, action, logp, entropy
    
    # Saves the model
    def save(self, filepath) -> None:
        torch.save(self.state_dict(), filepath)
    
    # Loads the model
    def load(self, filepath, device='cpu'):
        device = torch.device(device)
        self.load_state_dict(torch.load(filepath, map_location=device))
        self.to(device)