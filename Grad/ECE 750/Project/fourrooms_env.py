import cv2
import numpy as np
import gymnasium as gym
from gymnasium import spaces
import matplotlib.pyplot as plt

"""
TODO
OC Fourrooms setup:

Initially the goal is located in the east doorway and the initial state is drawn uniformly from all the other cells. 
After 1000 episodes, the goal moves to a random location in the lower right room. 
Primitive movements can fail with probability 1/3, in which case the agent transitions randomly to one of the empty adjacent cells. 
The discount factor was 0.99, and the reward was +1 at the goal and 0 otherwise.

AOC Fourrooms setup:

The chosen action is executed with probability 0.98 and a random action is executed with 0.02 probability. 
The reward is +20 upon reaching the goal, and -1 otherwise.
The agent starts in a uniformly random state and the goal is chosen randomly for each run of the algorithm.
"""

class Fourrooms(gym.Env):
    metadata = {
        'render_modes': ['human', 'rgb_array'],
        'render_fps': 50
    }

    def __init__(self, render_mode=None):
        layout = ["wwwwwwwwwwwww",    # Original
                  "w     w     w",
                  "w     w     w",
                  "w           w",
                  "w     w     w",
                  "w     w     w",
                  "ww wwww     w",
                  "w     www www",
                  "w     w     w",
                  "w     w     w",
                  "w           w",
                  "w     w     w",
                  "wwwwwwwwwwwww"]
        # layout = ["wwwwwwwwwwwww",  # Remove some walls
        #           "w     w     w",
        #           "w           w",
        #           "w           w",
        #           "w           w",
        #           "w     w     w",
        #           "w   www     w",
        #           "w     ww   ww",
        #           "w     w     w",
        #           "w           w",
        #           "w           w",
        #           "w           w",
        #           "wwwwwwwwwwwww"]
        
        # 1 if wall ('w'), else 0
        self.occupancy = np.array([list(map(lambda c: 1 if c == 'w' else 0, line)) for line in layout])
        
        # Four possible actions: up, down, left, right
        self.action_space = spaces.Discrete(4)
        
        # Observation is a one-hot encoded state for each available cell
        self.observation_space = spaces.Box(low=0., high=1., shape=(np.sum(self.occupancy == 0),), dtype=np.float32)
        
        self.directions = [np.array((-1, 0)), np.array((1, 0)), np.array((0, -1)), np.array((0, 1))]
        self.rng = np.random.default_rng(1234)  # Random number generator

        # Map states to cell coordinates and vice versa
        self.to_state = {}
        statenum = 0
        for i in range(len(layout)):
            for j in range(len(layout[0])):
                if self.occupancy[i, j] == 0:
                    self.to_state[(i, j)] = statenum
                    statenum += 1
        self.to_cell = {v: k for k, v in self.to_state.items()}

        self.goal = 62  # Goal is the East doorway
        # self.goal = 26    # Goal for simple env
        self.init_states = list(range(self.observation_space.shape[0])) # List of possible starting states
        self.init_states.remove(self.goal)
        self.ep_steps = 0

        self.env_epsilon = 0.02  # AOC paper: The chosen action is executed with probability 0.98 and a random action is executed with 0.02 probability
        self.render_mode = render_mode

    # Set the random seed
    def seed(self, seed=None):
        self.rng = np.random.default_rng(seed)
        return [seed]

    # Return the list of accessible cells around the current cell
    def get_empty_neighbours(self, cell):
        empty = []
        for action in range(self.action_space.n):
            next_cell = tuple(cell + self.directions[action])
            if not self.occupancy[next_cell]:
                empty.append(next_cell)
        return empty

    # Reset the environment
    def reset(self, *, seed=None, options=None):
        super().reset(seed=seed)
        if seed is not None:
            self.seed(seed)
        
        # Choose a new state to initialize from
        state = self.rng.choice(self.init_states)
        self.curr_cell = self.to_cell[state]
        self.ep_steps = 0
        return self.get_state(state), {}

    # Randomly change the goal to a new location
    def switch_goal(self):
        prev_goal = self.goal
        self.goal = self.rng.choice(self.init_states)
        self.init_states.append(prev_goal)
        self.init_states.remove(self.goal)
        assert prev_goal in self.init_states
        assert self.goal not in self.init_states

    # Return the one-hot encoded state
    def get_state(self, state):
        s = np.zeros(self.observation_space.shape[0])
        s[state] = 1
        return s

    # Render the environment
    def render(self, show_goal=True):
        # current_grid = np.array(self.occupancy)
        # current_grid[self.curr_cell[0], self.curr_cell[1]] = -1  # Agent position
        # if show_goal:
        #     goal_cell = self.to_cell[self.goal]
        #     current_grid[goal_cell[0], goal_cell[1]] = -1  # Goal position
        
        # Prepare the grid
        grid = np.array(self.occupancy)
        grid_rgb = np.zeros((*grid.shape, 3), dtype=np.uint8)

        # Fill in colors for walls, agent, and goal
        grid_rgb[grid == 1] = [0, 0, 0]  # Black for walls
        grid_rgb[grid == 0] = [255, 255, 255]  # White for empty spaces

        # Set the agent position
        grid_rgb[self.curr_cell[0], self.curr_cell[1]] = [255, 255, 0]  # Yellow for agent

        # Set the goal position
        if show_goal:
            goal_cell = self.to_cell[self.goal]
            grid_rgb[goal_cell[0], goal_cell[1]] = [0, 255, 0]  # Green for goal

        # Scale the image for better visibility
        scale_factor = 25
        grid_scaled = cv2.resize(
            grid_rgb, (grid.shape[1] * scale_factor, grid.shape[0] * scale_factor), interpolation=cv2.INTER_NEAREST
        )

        # Show the frame in a popup window
        cv2.imshow("Four Rooms Environment", grid_scaled)
        cv2.waitKey(1)

    # Take a step in the environment
    def step(self, action):
        self.ep_steps += 1

        next_cell = tuple(self.curr_cell + self.directions[action])
        
        # Take a random step to any available neighbour with epsilon chance (0.02)
        if self.rng.uniform() < self.env_epsilon:
            empty_cells = self.get_empty_neighbours(self.curr_cell)
            self.curr_cell = empty_cells[self.rng.integers(len(empty_cells))]

        # Else go to the chosen cell if it's available (0.98)
        elif not self.occupancy[next_cell]:
            self.curr_cell = next_cell
        
        state = self.to_state[self.curr_cell]
        
        # AOC paper: The reward is +20 upon reaching the goal, and -1 otherwise
        reward = -1
        done = False
        truncated = False
        if state == self.goal:
            done = True
            reward = 20
        elif self.ep_steps >= 1000: # Times out after 1000 steps
            truncated = True

        return self.get_state(state), reward, done, truncated, {}

if __name__ == "__main__":
    env = Fourrooms()
    env.reset(seed=3)
    print("Environment initialized.")
