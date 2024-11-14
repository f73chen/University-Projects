import torch
import torch.nn as nn
from torch.distributions import Categorical
import numpy as np
from copy import deepcopy

from replay_buffer import ReplayBuffer

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
                 epsilon_decay=int(1e6)) -> None:
        super(OptionCriticFeatures, self).__init__()
        
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
        self.option_critic_prime = deepcopy(self)
        
    # TODO
    def learn(self, total_timesteps) -> None:
        pass
    
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
        return action
    
    # Saves the model
    def save(self, filepath) -> None:
        torch.save(self.state_dict(), filepath)
    
    # Loads the model
    def load(self, filepath, device='cpu'):
        device = torch.device(device)
        self.load_state_dict(torch.load(filepath, map_location=device))
        self.to(device)