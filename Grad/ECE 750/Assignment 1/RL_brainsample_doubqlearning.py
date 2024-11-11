import numpy as np
import pandas as pd

from RL_brainsample_wrong import debug

class rlalgorithm:
    def __init__(self, actions, gamma=0.9, *args, **kwargs):
        self.display_name = "Double Q-Learning"
        self.Q1 = {}    # Train 2 action-value functions, Q1 and Q2
        self.Q2 = {}
        self.actions = actions
        self.num_actions = len(actions)
        
        self.gamma = gamma
        self.epsilon = 0.1
        self.alpha = 0.1
        debug(1, f'Init new RL Algorithm {self.display_name}: |A|={self.num_actions} A={self.actions}')

    def choose_action(self, observation, **kwargs):
        # Initialize states arbitrarily (zeros)
        if observation not in self.Q1:
            self.Q1[observation] = np.zeros(self.num_actions)
        if observation not in self.Q2:
            self.Q2[observation] = np.zeros(self.num_actions)
            
        # Choose A from S using policy derived from Q1 and Q2 (epsilon-greedy in Q1 + Q2)
        if np.random.uniform() >= self.epsilon:
            a = np.argmax(self.Q1[observation] + self.Q2[observation])
        else:
            a = np.random.choice(self.actions)
            
        return a

    def learn(self, s, a, r, s_, **kwargs):
        # Take action A, observe R, S'
        
        # Stop if S is terminal
        if s_ == 'terminal':
            a_ = None
            self.Q1[s][a] += self.alpha * (r - self.Q1[s][a])
            self.Q2[s][a] += self.alpha * (r - self.Q2[s][a])
            
        else:
            if s_ not in self.Q1:
                self.Q1[s_] = np.zeros(self.num_actions)
            if s_ not in self.Q2:
                self.Q2[s_] = np.zeros(self.num_actions)
            
            # Update each Q with 0.5 probability
            if np.random.uniform() <= 0.5:
                # Q1(S, A) <- Q1(S, A) + alpha(R + gamma * Q2(S', argmax a Q1(S', a)) - Q1(S, A))
                self.Q1[s][a] += self.alpha * (r + self.gamma * self.Q2[s_][np.argmax(self.Q1[s_])] - self.Q1[s][a])
            else:
                # Q2(S, A) <- Q2(S, A) + alpha(R + gamma * Q1(S', argmax a Q2(S', a)) - Q2(S, A))
                self.Q2[s][a] += self.alpha * (r + self.gamma * self.Q1[s_][np.argmax(self.Q2[s_])] - self.Q2[s][a])
                
            # Choose action after the update
            a_ = self.choose_action(observation=s_)

        # S <- S'; A <- A'
        return s_, a_