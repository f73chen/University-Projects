import gymnasium as gym
from stable_baselines3 import DQN
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv

import highway_env

environment_name = ["highway-fast-v0", "intersection-v0", "racetrack-v0"]
environment_fileName = ["highway", "intersection", "racetrack"]

TRAIN = True
current_env = 2

if __name__ == "__main__":
    n_cpu = 8
    env = make_vec_env(environment_name[current_env], n_envs=n_cpu, vec_env_cls=SubprocVecEnv)
    
    # highway
    model = DQN(
        policy="MlpPolicy",
        env=env,
        learning_rate=0.0006068671033128076,     # Learning rate
        gamma=0.8584598942343338,               # Discount factor
        target_update_interval=1000,            # Target network update interval
        batch_size=128,                          # Batch size for training
        buffer_size=70000,                      # Replay buffer size
        exploration_final_eps=0.11618448679159889,  # Final exploration epsilon
        exploration_fraction=0.2996291548466866,    # Fraction of training with exploration
        learning_starts=0,                   # Steps before learning starts
        train_freq=1,                           # Frequency of training
        policy_kwargs=dict(net_arch=[256,256]),            # Custom tiny architecture
        verbose=2,                               # Verbosity level
        tensorboard_log=f"results/{environment_fileName[current_env]}_dqn/"
    )
     

    
    # Train the model
    if TRAIN:
        model.learn(total_timesteps=int(1e5))
        model.save(f"results/{environment_fileName[current_env]}_dqn/model")
        del model
    #todo: fix this code
    # Run the algorithm
