import numpy as np
import pandas as pd

from RL_brainsample_wrong import debug

class rlalgorithm:
    def __init__(self, actions, gamma=0.9, *args, **kwargs):
        self.display_name = "Q-Learning"
        self.Q = {}
        self.actions = actions
        self.num_actions = len(actions)
        
        self.gamma = gamma
        self.epsilon = 0.1
        self.alpha = 0.1
        debug(1, f'Init new RL Algorithm {self.display_name}: |A|={self.num_actions} A={self.actions}')

    def choose_action(self, observation, **kwargs):
        # Initialize states arbitrarily (zeros)
        if observation not in self.Q:
            self.Q[observation] = np.zeros(self.num_actions)
            
        # Choose A from S using policy derived from Q (epsilon-greedy)
        if np.random.uniform() >= self.epsilon:
            a = np.argmax(self.Q[observation])
        else:
            a = np.random.choice(self.actions)
            
        return a

    def learn(self, s, a, r, s_, **kwargs):
        # Take action A, observe R, S'
        # Stop if S is terminal
        if s_ == 'terminal':
            a_ = None
            self.Q[s][a] += self.alpha * (r - self.Q[s][a])
            
        else:
            if s_ not in self.Q:
                self.Q[s_] = np.zeros(self.num_actions)
            
            # Q(S, A) <- Q(S, A) + alpha(R + gamma * max_a Q(S', a) - Q(S, A))
            self.Q[s][a] += self.alpha * (r + self.gamma * max(self.Q[s_]) - self.Q[s][a])
            
            # Choose action after the update
            a_ = self.choose_action(observation=s_)

        # S <- S'; A <- A'
        return s_, a_