import torch
import numpy as np
import random
from collections import deque

class ReplayBuffer:
    def __init__(self, capacity, device='cpu', seed=42):
        self.rng = random.SystemRandom(seed)
        self.buffer = deque(maxlen=capacity)
        self.device = device

    def add(self, obs, option, reward, next_obs, done):
        """Stores experience tuple in the buffer."""
        self.buffer.append((obs, option, reward, next_obs, done))

    def sample(self, batch_size):
        """Samples a batch of experiences, converts them to tensors, and moves to the specified device."""
        obs, option, reward, next_obs, done = zip(*self.rng.sample(self.buffer, batch_size))
        obs = torch.tensor(np.stack(obs), dtype=torch.float32, device=self.device)
        option = torch.tensor(option, dtype=torch.long, device=self.device)
        reward = torch.tensor(reward, dtype=torch.float32, device=self.device)
        next_obs = torch.tensor(np.stack(next_obs), dtype=torch.float32, device=self.device)
        done = torch.tensor(done, dtype=torch.float32, device=self.device)
        return obs, option, reward, next_obs, done

    def __len__(self):
        return len(self.buffer)
