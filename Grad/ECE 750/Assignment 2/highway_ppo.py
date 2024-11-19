import gymnasium as gym
from stable_baselines3 import PPO
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv

import highway_env

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning) 

# ENV = "highway-fast-v0"
# ENV = "intersection-v0"
ENV = "racetrack-v0"
ENV_TYPE = "racetrack"
MODEL_TYPE = "ppo_default"

if __name__ == "__main__":
    n_cpu = 8
    batch_size = 64
    env = make_vec_env(ENV, n_envs=n_cpu, vec_env_cls=SubprocVecEnv)
    model = PPO(
        "MlpPolicy",
        env,
        # policy_kwargs=dict(net_arch=[dict(pi=[256, 256], vf=[256, 256])]),
        # n_steps=batch_size * 12 // n_cpu,
        batch_size=batch_size,
        # n_epochs=10,
        # learning_rate=5e-4,
        # gamma=0.9,
        verbose=1,
        tensorboard_log=f"results/{ENV_TYPE}_{MODEL_TYPE}/",
    )
    
    # Train the model
    model.learn(total_timesteps=int(2e5))
    model.save(f"results/{ENV_TYPE}_{MODEL_TYPE}/model")

    # # Run the algorithm
    # model = PPO.load(f"results/{ENV_TYPE}_{MODEL_TYPE}/model", env=env)

    # env = gym.make(ENV, render_mode="rgb_array")
    # for episode in range(10):
    #     done = truncated = False
    #     obs, info = env.reset()
    #     while not (done or truncated):
    #         action, _states = model.predict(obs, deterministic=True)
    #         obs, reward, done, truncated, info = env.step(action)
    #         env.render()
    # env.close()