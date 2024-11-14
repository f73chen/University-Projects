import torch
import torch.nn as nn
from torch.distributions import Categorical
import numpy as np
from copy import deepcopy

from replay_buffer import ReplayBuffer
from utils import actor_loss, critic_loss

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
                 train_freq=1,
                 target_update_freq=50,
                 buffer_size=10000) -> None:
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
        self.train_freq = train_freq
        self.target_update_freq = target_update_freq
        self.buffer_size = buffer_size
        
        # TODO: Make epsilon a class property
        self.epsilon = 1.0
        
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
        
        # Target network for training stability
        self.target_network = deepcopy(self)
        
    # TODO: Test both copy methods
    def update_target_network(self, hard=True, tau=0.005):
        # Hard copy: Directly copy all parameters to the target network
        # Better if updates are less frequent
        if hard:
            self.target_network.load_state_dict(self.state_dict())
            
        # Soft copy: Gradually change the target network towards the policy network
        # Better if updates are more frequent
        else:
            for target_param, param in zip(self.target_network.parameters(), self.parameters()):
                target_param.data.copy_(tau * param.data + (1.0 - tau) * target_param.data)
        
    # TODO
    def learn(self, total_timesteps) -> None:
        obs, _ = self.env.reset()
        episode_reward = 0
        replay_buffer = ReplayBuffer(capacity=self.buffer_size)
        optimizer = torch.optim.AdamW(self.parameters(), lr=self.learning_rate)
        
        for step in range(total_timesteps):
            # Choose an option and action using epsilon-greedy
            # TODO: Double check epsilon is implemented correctly (logging)
            # TODO: Terminate options according to termination_prob
            option, action, logp, entropy = self.predict(obs, deterministic=False)
            
            # Take a step in the environment
            next_obs, reward, done, truncated, _ = self.env.step(action)
            replay_buffer.add(obs, option, reward, next_obs, done)
            
            obs = next_obs
            episode_reward += reward
            
            # Reset environment if done or truncated
            if done or truncated:
                print(f"Episode finished with reward: {episode_reward}")
                obs, _ = self.env.reset()
                episode_reward = 0
                
            # Sample from buffer and train
            if len(replay_buffer) >= self.batch_size and step % self.train_freq == 0:
                batch = replay_buffer.sample(self.batch_size)
                actor_loss_value = actor_loss(self, self.target_network, obs, option, reward, next_obs, done, logp, entropy)
                critic_loss_value = critic_loss() # TODO
                
                # Optimization step
                loss = actor_loss_value + critic_loss_value
                optimizer.zero_grad()
                loss.backward()
                optimizer.step()
                
            # Update the target network every few steps
            if step % self.target_update_freq == 0:
                self.update_target_network(hard=True)
    
    # Helper: Return the option index with the highest Q_Omega value
    def greedy_option(self, state):
        # Calculate Q_Omega for each option
        # print(state)
        Q_Omegas = self.Q(state)
        # print(Q_Omegas)
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
    def predict(self, obs, deterministic=True) -> int:
        # Flatten the observations to 1D and add a batch dimension
        obs_tensor = torch.tensor(obs, dtype=torch.float32).reshape(1, -1).to(self.device)
        
        # Get the output of the shared network
        state = self.features(obs_tensor)
        
        # Choose an option
        if deterministic or np.random.random() > self.epsilon:
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