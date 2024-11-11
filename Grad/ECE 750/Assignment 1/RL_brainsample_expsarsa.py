import numpy as np
import pandas as pd

from RL_brainsample_wrong import debug

class rlalgorithm:
    def __init__(self, actions, gamma=0.9, *args, **kwargs):
        self.display_name = "Expected SARSA"
        self.Q = {}
        self.actions = actions
        self.num_actions = len(actions)
        
        self.gamma = gamma
        self.epsilon = 0.1
        self.alpha = 0.1
        debug(1, f'Init new RL Algorithm {self.display_name}: |A|={self.num_actions} A={self.actions}')

    def choose_action(self, observation, **kwargs):
        if observation not in self.Q:
            self.Q[observation] = np.zeros(self.num_actions)
        
        if np.random.uniform() >= self.epsilon:
            a = np.argmax(self.Q[observation])
        else:
            a = np.random.choice(self.actions)
            
        return a

    def learn(self, s, a, r, s_, **kwargs):
        # Stop if S is terminal
        if s_ == 'terminal':
            a_ = None
            self.Q[s][a] += self.alpha * (r - self.Q[s][a])
            
        else:
            if s_ not in self.Q:
                self.Q[s_] = np.zeros(self.num_actions)
                
            # Instead of the sample value of next state, use the expectation
            best_action = np.argmax(self.Q[s_])
            expected_qs_ = 0
            for action in range(self.num_actions):
                if action == best_action:
                    prob = (1 - self.epsilon) + (self.epsilon / self.num_actions)
                else:
                    prob = self.epsilon / self.num_actions
                expected_qs_ += prob * self.Q[s_][action]
            
            # Q(S, A) <- Q(S, A) + alpha[R + gamma * Expected Q(S') - Q(S, A)]
            self.Q[s][a] += self.alpha * (r + self.gamma * expected_qs_ - self.Q[s][a])
            
            # Choose action after the update
            a_ = self.choose_action(observation=s_)

        # S <- S'; A <- A'
        return s_, a_