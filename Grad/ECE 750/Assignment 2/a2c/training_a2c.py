import gymnasium as gym
from stable_baselines3 import A2C
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv
import torch

import highway_env

environment_name = ["highway-fast-v0", "intersection-v0", "racetrack-v0"]
environment_fileName = ["highway", "intersection", "racetrack"]
current_env = 0


TRAIN = True

if __name__ == "__main__":
    n_cpu = 8
    env = make_vec_env(environment_name[current_env], n_envs=n_cpu, vec_env_cls=SubprocVecEnv)

    obs, info = env.reset(), {}
    # racetrack model
    # #Define the policy_kwargs
    policy_kwargs = dict(
        net_arch=[64, 64],  # 'medium' architecture: two hidden layers with 64 units each
        activation_fn=torch.nn.Tanh,  # Tanh activation function
        ortho_init=True  # Orthogonal initialization
    )

    
    # # race track
    # model = A2C(
    #     "MlpPolicy",  # Multi-Layer Perceptron policy
    #     env,
    #     gamma=0.99,
    #     normalize_advantage=True,
    #     max_grad_norm=2,
    #     use_rms_prop=True,
    #     gae_lambda=0.8,
    #     n_steps=16,
    #     learning_rate=0.00020818203769485367,  # Constant learning rate
    #     ent_coef=3.544295288971436e-08,  # Entropy coefficient
    #     vf_coef=0.0956287277939818,  # Value function coefficient
    #     policy_kwargs=policy_kwargs,
    #     verbose=2, 
    #     tensorboard_log=f"results/{environment_fileName[2]}_a2c/",
    # )

    # intersection
    # model = A2C(
    #     policy="MlpPolicy",
    #     env=env,
    #     gamma=0.95,
    #     normalize_advantage=True,
    #     max_grad_norm=0.5,
    #     use_rms_prop=False,
    #     gae_lambda=0.92,
    #     n_steps=32,
    #     learning_rate=0.5662682891050249,
    #     ent_coef=0.03224695098375864,
    #     vf_coef=0.08772542008361817,
    #     policy_kwargs=policy_kwargs,
    #     verbose=2,
    #     tensorboard_log=f"results/{environment_fileName[current_env]}_a2c/",   
    # ) 
    # highway
    model = A2C(
        policy="MlpPolicy",
        env=env,
        gamma=0.9999,                     # Discount factor
        normalize_advantage=True,         # Normalize advantage
        max_grad_norm=2,                  # Maximum gradient norm
        use_rms_prop=True,                # Use RMSProp optimizer
        gae_lambda=0.8,                   # GAE Lambda
        n_steps=16,                       # Number of steps to run for each environment per update
        learning_rate=0.00020818203769485367,  # Learning rate
        ent_coef=3.544295288971436e-08,   # Entropy coefficient
        vf_coef=0.0956287277939818,       # Value function coefficient
        verbose=2,                         # Verbosity level
        policy_kwargs=policy_kwargs,
        tensorboard_log=f"results/{environment_fileName[current_env]}_a2c/", 
    )
     

    
    # Train the model
    if TRAIN:
        model.learn(total_timesteps=int(2e5))
        model.save(f"results/{environment_fileName[current_env]}_a2c/model")
        del model

    # Run the algorithm
    # model = A2C.load(f"results/{environment_fileName[current_env]}_a2c/model", env=env)

    # env = gym.make(environment_name[current_env], render_mode="rgb_array")

    # for episode in range(10):
    #     done = truncated = False
    #     obs, info = env.reset(), {}
    #     while not (done or truncated):
    #         action, _states = model.predict(obs, deterministic=True)
    #         obs, reward, done, truncated, info = env.step(action)
    #         env.render()
    # env.close()