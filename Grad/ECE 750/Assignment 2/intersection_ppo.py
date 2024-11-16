import gymnasium as gym
from stable_baselines3 import PPO
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv

import highway_env

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning) 

TRAIN = False

if __name__ == "__main__":
    n_cpu = 6
    batch_size = 64
    env = make_vec_env("intersection-v0", n_envs=n_cpu, vec_env_cls=SubprocVecEnv)
    model = PPO(
        "MlpPolicy",
        env,
        policy_kwargs=dict(net_arch=[dict(pi=[256, 256], vf=[256, 256])]),
        n_steps=batch_size * 12 // n_cpu,
        batch_size=batch_size,
        n_epochs=10,
        learning_rate=5e-4,
        gamma=0.9,
        verbose=2,
        tensorboard_log="results/intersection_ppo/",
    )
    
    # Train the model
    if TRAIN:
        model.learn(total_timesteps=int(1e5))
        model.save("results/intersection_ppo/model")
        del model

    # Run the algorithm
    model = PPO.load("results/intersection_ppo/optimized_model", env=env)

    env = gym.make("intersection-v0", render_mode="rgb_array")

    for episode in range(10):
        done = truncated = False
        obs, info = env.reset()
        while not (done or truncated):
            action, _states = model.predict(obs, deterministic=True)
            obs, reward, done, truncated, info = env.step(action)
            env.render()
    env.close()