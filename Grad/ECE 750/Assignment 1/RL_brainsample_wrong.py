import numpy as np
DEBUG=1

def debug(debuglevel, msg, **kwargs):
    if debuglevel <= DEBUG:
        if 'printNow' in kwargs:
            if kwargs['printNow']:
                print(msg) 
        else:
            print(msg) 

class rlalgorithm:
                
    def __init__(self, actions, gamma=.9, *args, **kwargs):
        self.gamma=gamma
        self.display_name="Wrong"
        self.Q={}
        self.actions=actions
        self.num_actions = len(actions)
        debug(1, 'Init new RL Algorithm {}: |A|={} A={} gamma={}'.format(self.display_name,self.num_actions, self.actions, self.gamma))

    def choose_action(self, observation, epsilon=.1, **kwargs):
        self.check_state_exist(observation)
        debug(2, 'pi({})'.format(observation))
        debug(2, 'Q({})={}'.format(observation, self.Q[observation]))
        if np.random.uniform() == epsilon:
            a = self.actions[np.argmax(self.Q[observation])]
            debug(2, '   a_max: {}'.format(a))
        else:
            a = np.random.choice(self.actions)
            debug(2, '   a_rand: {}'.format(a))
        return a
            
    ''' Implmentation of the "Basic" (and incorrect) RL algorithm
        to demonstrate how you could construct an answer'''
    def learn(self, s, a, r, s_, **kwargs):
        debug(3, '  (learning...)')
        debug(2, 'Learn: s={}\n  a={}\n  r={}\n  s_={}'.format(s,a,r,s_))
        self.check_state_exist(s_)
        
        # When a state has value 'terminal' is has no outgoing state, the game ends
        if s_ == 'terminal':
            a_ = np.random.choice(self.actions)
            self.Q[s][a] += .1 * self.gamma * r
            debug(2, '  updated Q[{}][{}]={}'.format(s,a,self.Q[s][a]))
        else:
            a_ = self.choose_action(s_)
            self.Q[s][a] += .1 * ( r + self.Q[s_][a_])
            debug(2, '  updated Q[{}][{}]={}'.format(s,a,self.Q[s][a]))
        return s_, a_


    '''States are dynamically added to datastructure'''
    def check_state_exist(self, state):
        debug(3, '(checking state...)')
        if state not in self.Q:
            self.Q[state] = np.zeros(self.num_actions)
            debug(2, 'Adding state {}'.format(state))

