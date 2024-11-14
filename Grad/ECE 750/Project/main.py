import gymnasium as gym
import highway_env
from highway_env.envs.intersection_env import IntersectionEnv
import ale_py

from option_critic import OptionCriticFeatures
from utils import actor_loss

# intersection_config = IntersectionEnv.default_config()
# intersection_config["observation"]["flatten"] = True

# Feature input, Discrete action space
env = gym.make("CartPole-v1", render_mode='rgb_array')      # (4,) --> 2
# env = gym.make("LunarLander-v3", render_mode='rgb_array')   # (8,) --> 4
# env = gym.make("highway-fast-v0", render_mode='rgb_array')  # (5, 5) --> 5
# env = gym.make("intersection-v0", render_mode='rgb_array')  # (15, 7) --> 3

# Feature input, Continuous action space
# env = gym.make("intersection-v1", render_mode='rgb_array')  # (5, 8) --> -1, 1, (2,)
# env = gym.make("racetrack-v0", render_mode='rgb_array')     # (2, 12, 12)

# Image input, Discrete action space
# env = gym.make("ALE/Pong-v5", render_mode='rgb_array')      # (210, 160, 3)

obs, info = env.reset()

oc = OptionCriticFeatures(env=env, num_options=4)

option, action, logp, entropy = oc.predict(obs, deterministic=True)
next_obs, reward, done, truncated, _ = env.step(action)
actor_loss_value = actor_loss(oc, oc.target_network, obs, option, reward, next_obs, done, logp, entropy)
print(actor_loss_value)