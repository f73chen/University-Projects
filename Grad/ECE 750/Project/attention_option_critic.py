import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np

from option_critic import OptionCriticFeatures
from replay_buffer import ReplayBuffer
from utils import actor_loss_aoc, critic_loss_oc
from logger import Logger

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
                 diversity_reg=4.0,  # TODO # AOC only
                 sparsity_reg=2.0,   # TODO # AOC only
                 smoothness_reg=1.0, # TODO # AOC only
                 
                 hidden_size=32,
                 state_size=64,
                 
                 learning_rate=1e-4,
                 batch_size=64,
                 critic_freq=10,
                 target_update_freq=50,
                 buffer_size=10000,
                 
                 tensorboard_log=None,
                 verbose=1,
                 is_policy_network=True) -> None:
        super(AOCFeatures, self).__init__()
        
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
        self.tau = tau
        
        self.termination_reg = termination_reg
        self.entropy_reg = entropy_reg
        self.diversity_reg = diversity_reg
        self.sparsity_reg = sparsity_reg
        self.smoothness_reg = smoothness_reg
        
        self.learning_rate = learning_rate
        self.batch_size = batch_size
        self.critic_freq = critic_freq
        self.target_update_freq = target_update_freq
        self.buffer_size = buffer_size
        
        self.tensorboard_log = tensorboard_log
        self.verbose = verbose

        # Learnable attention mask (AOC only)
        self.attention = nn.ModuleList([
            nn.Sequential(
                nn.Linear(self.in_features, self.in_features),
                nn.Sigmoid()
            ) for _ in range(num_options)
        ])

        # Shared network
        self.features = nn.Sequential(
            nn.Linear(self.in_features, hidden_size),
            nn.ReLU(),
            nn.Linear(hidden_size, state_size),
            nn.ReLU()
        )

        # Q_Omega head
        self.Q = nn.Linear(state_size, num_options)

        # Termination head
        self.terminations = nn.Linear(state_size, num_options)

        # Intra-option policy (pi_w) weights and biases
        self.options_W = nn.Parameter(torch.empty(num_options, state_size, self.num_actions, device=device))
        torch.nn.init.xavier_uniform_(self.options_W)
        self.options_b = nn.Parameter(torch.zeros(num_options, self.num_actions, device=device))

        # Target network
        if is_policy_network:
            self.target_network = AOCFeatures(env, num_options, device,
                                              temperature, epsilon_start, epsilon_min, epsilon_decay, gamma, tau,
                                              termination_reg, entropy_reg, diversity_reg, sparsity_reg, smoothness_reg,
                                              hidden_size, state_size,
                                              learning_rate, batch_size, critic_freq, target_update_freq, buffer_size,
                                              tensorboard_log, verbose, is_policy_network=False)
            self.update_target_network()
        else:
            self.target_network = None

        self.to(device)

    # TODO: Verify
    def apply_attention(self, obs, option):
        obs_tensor = torch.tensor(obs, dtype=torch.float32).to(self.device).reshape(1, -1)
        attention_mask = self.attention[option](obs_tensor)
        return attention_mask * obs_tensor

    # TODO: Overwrite self.learn() if need to log attention metrics to tensorboard
    
    # Helper: Return the option index with the highest Q-value given attention
    def greedy_option(self, obs):
        attended_obs = [self.apply_attention(obs, option) for option in range(self.num_options)]
        states = [self.features(att_obs) for att_obs in attended_obs]
        Q_Omegas = torch.stack([self.Q(state) for state in states]).squeeze()
        return Q_Omegas.argmax(dim=-1).item()

    def predict(self, obs, option, option_termination, epsilon=1.0, deterministic=False):
        # Choose a new option if the previous one terminates
        if option_termination:
            if deterministic or np.random.random() > epsilon:
                option = self.greedy_option(state)
            else:
                option = np.random.randint(0, self.num_options)

        # Choose an action based on the chosen option
        attended_obs = self.apply_attention(obs, option)
        state = self.features(attended_obs)
        action, logp, entropy = self.get_action(state, option)

        return option, action, logp, entropy

    # Helper: Attentions between different options should be distinct
    # TODO: Test
    def get_diversity_loss(self):
        attention_masks = [att.weight for att in self.attention]
        total_similarity = 0
        # Get the total cosine similarity between every pair of option attentions
        for i in range(len(attention_masks)):
            for j in range(i + 1, len(attention_masks)):
                total_similarity += F.cosine_similarity(attention_masks[i], attention_masks[j]).mean()
        return self.diversity_reg * total_similarity

    # Helper: Attention weights should be as small as possible
    # TODO: Test
    def get_sparsity_loss(self):
        sparsity_loss = 0
        for att in self.attention:
            sparsity_loss += att.weight.abs().sum()
        return self.sparsity_reg * sparsity_loss

    # Helper: Attentions for the same option should be consistent across a trajectory
    # TODO: Implement
    def get_smoothness_loss(self):
        return self.smoothness_reg * 0
