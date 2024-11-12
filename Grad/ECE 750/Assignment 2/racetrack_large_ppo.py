import gymnasium as gym
from stable_baselines3 import PPO

import highway_env

from racetrack_env_large import RacetrackEnvLarge


if __name__ == "__main__":

     gym.envs.register(
          id='racetrack-large-v0',
          entry_point='racetrack_env_large:RacetrackEnvLarge',
          max_episode_steps=1000,
     )
     
     env = gym.make("racetrack-large-v0", render_mode="rgb_array")
     model = PPO.load("results/racetrack_ppo/model", env=env)

     for episode in range(1):
          done = truncated = False
          obs, info = env.reset()
          while not (done or truncated):
              action, _states = model.predict(obs, deterministic=True)
              obs, reward, done, truncated, info = env.step(action)
              env.render()
     env.close()