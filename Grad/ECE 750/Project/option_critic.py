import torch
import torch.nn as nn
import numpy as np
from copy import deepcopy

from replay_buffer import ReplayBuffer

class OptionCriticFeatures(nn.Module):
    # TODO: Add tensorboard_log
    def __init__(self,
                 in_features,
                 num_actions,
                 num_options,
                 device="cpu") -> None:
        super(OptionCriticFeatures, self).__init__()
        
        self.in_features = in_features
        self.num_actions = num_actions
        self.num_options = num_options
        
        self.device = device
        
        # Shared network
        self.features = nn.Sequential(
            nn.Linear(in_features, 32),
            nn.ReLU(),
            nn.Linear(32, 64),
            nn.ReLU()
        )
        
        # Q_Omega head
        self.Q = nn.Linear(64, num_options)
        
        # beta_w head
        self.terminations = nn.Linear(64, num_options)
        
        # pi_w head weights and biases
        self.options_W = nn.Parameter(torch.zeros(num_options, 64, num_actions, device=device))
        self.options_b = nn.Parameter(torch.zeros(num_options, num_actions, device=device))
        
        self.to(device)
        
        # Target network for training stability
        self.option_critic_prime = deepcopy(self)
        
    # TODO
    def learn(self, total_timesteps) -> None:
        pass
    
    # TODO
    def predict(self, obs, deterministic=True):
        # Return action, _states
        pass
    
    # Saves the model
    def save(self, filepath) -> None:
        torch.save(self.state_dict(), filepath)
    
    # Loads the model
    def load(self, filepath, device='cpu'):
        device = torch.device(device)
        self.load_state_dict(torch.load(filepath, map_location=device))
        self.to(device)