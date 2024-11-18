import gymnasium as gym
from stable_baselines3 import DQN
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv

import highway_env

environment_name = ["highway-fast-v0", "intersection-v0", "racetrack-v0"]
environment_fileName = ["highway", "intersection", "racetrack"]

TRAIN = True
current_env = 1

if __name__ == "__main__":
    n_cpu = 8
    env = make_vec_env(environment_name[current_env], n_envs=n_cpu, vec_env_cls=SubprocVecEnv)
    
    # highway
    model = DQN(
        policy="MlpPolicy",
        env=env,
        learning_rate=0.0007707467520043714,     # Learning rate
        gamma=0.8592031466655873,               # Discount factor
        target_update_interval=1000,            # Target network update interval
        batch_size=32,                          # Batch size for training
        buffer_size=10000,                      # Replay buffer size
        exploration_final_eps=0.07642725874918004,  # Final exploration epsilon
        exploration_fraction=0.252843163714334,    # Fraction of training with exploration
        learning_starts=1000,                   # Steps before learning starts
        train_freq=1,                           # Frequency of training
        policy_kwargs=dict(net_arch=[64]),            # Custom tiny architecture
        verbose=2,                               # Verbosity level
        tensorboard_log=f"results/{environment_fileName[current_env]}_dqn/"
    )
     

    
    # Train the model
    if TRAIN:
        model.learn(total_timesteps=int(2e5))
        model.save(f"results/{environment_fileName[current_env]}_dqn/model")
        del model
    #todo: fix this code
    # Run the algorithm
    model = DQN.load(f"results/{environment_fileName[current_env]}_dqn/model", env=env)

    env = gym.make("highway-fast-v0", render_mode="rgb_array")

    for episode in range(10):
        done = truncated = False
        obs, info = env.reset()
        while not (done or truncated):
            action, _states = model.predict(obs, deterministic=True)
            obs, reward, done, truncated, info = env.step(action)
            env.render()
    env.close()