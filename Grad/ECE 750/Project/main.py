import gymnasium as gym
import highway_env
from highway_env.envs.intersection_env import IntersectionEnv
import ale_py

from option_critic import OptionCriticFeatures

# intersection_config = IntersectionEnv.default_config()
# intersection_config["observation"]["flatten"] = True

# Feature input, Discrete action space
ENV_NAME = "CartPole-v1"      # (4,) --> 2
# ENV_NAME = "LunarLander-v3"     # (8,) --> 4
# ENV_NAME = "highway-fast-v0"  # (5, 5) --> 5
# ENV_NAME = "intersection-v0"  # (15, 7) --> 3

# Feature input, Continuous action space
# ENV_NAME = "intersection-v1"  # (5, 8) --> -1, 1, (2,)
# ENV_NAME = "racetrack-v0"     # (2, 12, 12)

# Image input, Discrete action space
# ENV_NAME = "ALE/Pong-v5"    # (210, 160, 3)

RENDER_MODE = None
# RENDER_MODE = "rgb_array"
# RENDER_MODE = "human"

env = gym.make(ENV_NAME, render_mode=RENDER_MODE)
obs, info = env.reset()

oc = OptionCriticFeatures(env=env, 
                          num_options=2, 
                          device="cpu",
                          temperature=1.0,
                          epsilon_start=1.0,
                          epsilon_min=0.1,
                          epsilon_decay=int(1e5),
                          gamma=0.95,
                          termination_reg=0.01,
                          entropy_reg = 0.01,
                          learning_rate=1e-3,
                          batch_size=64,
                          critic_freq=10,
                          target_update_freq=10,
                          buffer_size=10000,
                          tensorboard_log="results/lunarlander_oc/")
oc.learn(total_timesteps=100000)
oc.save("results/cartpole_oc/model")

# env.unwrapped.config["simulation_frequency"] = 15
# oc.load("results/lunarlander_oc/model")
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