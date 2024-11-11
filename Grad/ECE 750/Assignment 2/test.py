import gymnasium as gym
import highway_env
from matplotlib import pyplot as plt

env = gym.make('highway-fast-v0', render_mode='rgb_array')
# env = gym.make('intersection-v0', render_mode='rgb_array')
# env = gym.make('racetrack-v0', render_mode='rgb_array')

# print(env.unwrapped.action_type.get_available_actions())
# print(env.unwrapped.config)
# print(env.action_space)

obs, info = env.reset()
done = truncated = False
while not (done or truncated):
    action = 1  # Idle
    obs, reward, done, truncated, info = env.step(action)
    env.render()