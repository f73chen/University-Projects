import gymnasium as gym
import highway_env
from highway_env.envs.intersection_env import IntersectionEnv
import ale_py

from option_critic import OptionCriticFeatures

# intersection_config = IntersectionEnv.default_config()
# intersection_config["observation"]["flatten"] = True

# Feature input, Discrete action space
# env = gym.make("CartPole-v1", render_mode='rgb_array')      # (4,) --> 2
# env = gym.make("LunarLander-v3", render_mode='rgb_array')   # (8,) --> 4
env = gym.make("highway-fast-v0", render_mode='rgb_array')  # (5, 5) --> 5
# env = gym.make("intersection-v0", render_mode='rgb_array')  # (15, 7) --> 3

# Feature input, Continuous action space
# env = gym.make("intersection-v1", render_mode='rgb_array')  # (5, 8) --> -1, 1, (2,)
# env = gym.make("racetrack-v0", render_mode='rgb_array')     # (2, 12, 12)

# Image input, Discrete action space
# env = gym.make("ALE/Pong-v5", render_mode='rgb_array')      # (210, 160, 3)

obs, info = env.reset()

oc = OptionCriticFeatures(env=env, num_options=4, tensorboard_log="results/highway_oc/")
oc.learn(total_timesteps=1000)
# oc.save("results/highway_oc/model")

# env.unwrapped.config["simulation_frequency"] = 15
# for episode in range(10):
#     done = truncated = False
#     obs, info = env.reset()
#     option = None
#     option_termination = True
#     while not (done or truncated):
#         option, action, logp, entropy = oc.predict(obs, option, option_termination, deterministic=True)
#         option_termination = oc.get_option_termination(obs, option)
#         obs, reward, done, truncated, info = env.step(action)
#         env.render()
# env.close()