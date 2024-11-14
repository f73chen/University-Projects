import torch
import torch.nn as nn
from torch.distributions import Categorical, Bernoulli
from math import exp
import numpy as np
from copy import deepcopy

from Project.replay_buffer import ReplayBuffer
from Project.utils_draft import actor_loss, critic_loss


class OptionCriticConv(nn.Module):
    def __init__(self,
                 in_features,
                 num_actions,
                 num_options,
                 temperature=1.0,
                 eps_start=1.0,
                 eps_min=0.1,
                 eps_decay=int(1e6),
                 eps_test=0.05,
                 device='cpu',
                 testing=False):
        
        super(OptionCriticConv, self).__init__()
        
        self.in_channels = in_features
        self.num_actions = num_actions
        self.num_options = num_options
        self.magic_number = 7 * 7 * 64
        self.device = device
        self.testing = testing

        self.temperature = temperature
        self.eps_min = eps_min
        self.eps_start = eps_start
        self.eps_decay = eps_decay
        self.eps_test = eps_test
        self.num_steps = 0

        self.features = nn.Sequential(
            nn.Conv2d(self.in_channels, 32, kernel_size=8, stride=4),
            nn.ReLU(),
            nn.Conv2d(32, 64, kernel_size=4, stride=2),
            nn.ReLU(),
            nn.Conv2d(64, 64, kernel_size=3, stride=1),
            nn.ReLU(),
            nn.Flatten(),
            nn.Linear(self.magic_number, 512),
            nn.ReLU()
        )

        self.Q = nn.Linear(512, num_options)  # Policy-Over-Options
        self.terminations = nn.Linear(512, num_options)  # Option-Termination
        self.options_W = nn.Parameter(torch.zeros(num_options, 512, num_actions, device=self.device))
        self.options_b = nn.Parameter(torch.zeros(num_options, num_actions, device=self.device))

        self.to(device)
        
        self.option_critic_prime = deepcopy(self)

    def reset(self, env):
        # Reset the environment to obtain the initial observation
        obs, info = env.reset()
        
        # Initialize any agent-specific variables
        self.current_option = self.greedy_option(self.get_state(obs))  # Select an initial option
        self.episode_reward = 0  # Reset episode reward counter, if needed for tracking

        return obs, info

    def predict(self, obs, deterministic=True):
        """
        Select an action based on the current observation.

        Args:
        - obs (np.array or torch.Tensor): The current observation from the environment.
        - deterministic (bool): If True, uses a greedy approach for option selection. If False, introduces randomness.

        Returns:
        - action (int): The selected action.
        """
        # Convert observation to tensor and get the state (shared feature representation)
        state = self.get_state(torch.tensor(obs, dtype=torch.float32).unsqueeze(0).to(self.device))
        
        # Determine the current option based on epsilon-greedy policy or greedy selection if deterministic
        if deterministic or torch.rand(1).item() > self.epsilon:
            option = self.greedy_option(state)
        else:
            option = torch.randint(0, self.num_options, (1,)).item()

        # Get the action for the selected option
        action, _, _ = self.get_action(state, option)
        
        return action

    def predict_option_termination(self, state, current_option):
        termination = self.terminations(state)[:, current_option].sigmoid()
        option_termination = Bernoulli(termination).sample()
        
        Q = self.get_Q(state)
        next_option = Q.argmax(dim=-1)
        return bool(option_termination.item()), next_option.item()
    
    def update_target_network(self):
        for target_param, param in zip(self.option_critic_prime.parameters(), self.parameters()):
            target_param.data.copy_(param.data)

    def learn(self, env, total_timesteps, batch_size=64, gamma=0.99, update_freq=4, target_update_freq=1000):
        obs, _ = env.reset()
        episode_reward = 0
        replay_buffer = ReplayBuffer(capacity=10000)
        optimizer = torch.optim.Adam(self.parameters(), lr=1e-4)
        
        for step in range(total_timesteps):
            # Choose an option and action using epsilon-greedy
            features = self.get_state(torch.FloatTensor(obs).to(self.device))
            current_option = self.greedy_option(features) if np.random.rand() > self.epsilon else np.random.randint(self.num_options)
            action, logp, entropy = self.get_action(features, current_option)

            # Take a step in the environment
            next_obs, reward, done, truncated, _ = env.step(action)
            replay_buffer.add(obs, current_option, reward, next_obs, done)
            
            obs = next_obs
            episode_reward += reward
            
            # Reset environment if done or truncated
            if done or truncated:
                print(f"Episode finished with reward: {episode_reward}")
                obs, _ = env.reset()
                episode_reward = 0

            # Sample and train
            if len(replay_buffer) >= batch_size and step % update_freq == 0:
                batch = replay_buffer.sample(batch_size)
                critic_loss_value = critic_loss(self, self, batch, gamma)
                actor_loss_value = actor_loss(self, batch, gamma)
                
                # Perform optimization step
                loss = critic_loss_value + actor_loss_value
                optimizer.zero_grad()
                loss.backward()
                optimizer.step()

            # Update target network every target_update_freq steps
            if step % target_update_freq == 0:
                self.update_target_network()

    def update(self, batch, args):
        """
        Performs a single update step for both actor and critic based on a batch of experiences.

        Args:
            batch (tuple): A batch of experiences from the replay buffer (obs, options, rewards, next_obs, dones).
            args: Arguments object containing gamma, entropy regularization, termination regularization, etc.

        Returns:
            critic_loss_value (float): Loss value for the critic.
            actor_loss_value (float): Loss value for the actor.
        """
        obs, options, rewards, next_obs, dones = batch

        # 1. Critic Update
        critic_loss_value = critic_loss(self.model, self.model_prime, batch, args)
        self.optimizer.zero_grad()
        critic_loss_value.backward()
        self.optimizer.step()

        # 2. Actor Update
        actor_loss_value = 0
        for i in range(len(options)):
            option = options[i]
            logp, entropy = self.get_logp_and_entropy(obs[i], option)
            actor_loss_value += actor_loss(
                obs[i],
                option,
                logp,
                entropy,
                rewards[i],
                dones[i],
                next_obs[i],
                self.model,
                self.model_prime,
                args
            )
        
        actor_loss_value = actor_loss_value / len(options)  # Average loss across batch
        self.optimizer.zero_grad()
        actor_loss_value.backward()
        self.optimizer.step()

        return critic_loss_value.item(), actor_loss_value.item()
    
    def compute_q_values(self, state, option):
        """
        Computes Q-values for actions within a specified option.
        
        Args:
            state (torch.Tensor): The processed feature vector from the environment's state.
            option (int): The current option for which Q-values are calculated.

        Returns:
            torch.Tensor: Q-values for each action within the given option.
        """
        # Compute the logits for the intra-option policy using the specific option's weights and biases
        logits = state.to(self.device) @ self.options_W[option] + self.options_b[option]
        q_values = logits  # Q-values are derived directly from the logits for each action

        return q_values
        
    @property
    def epsilon(self):
        if not self.testing:
            eps = self.eps_min + (self.eps_start - self.eps_min) * exp(-self.num_steps / self.eps_decay)
            self.num_steps += 1
        else:
            eps = self.eps_test
        return eps


