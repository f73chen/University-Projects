import gymnasium as gym
from stable_baselines3 import DQN

import highway_env
from highway_env.envs.racetrack_env import RacetrackEnv

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)

ENV = "highway-fast-v0"
# ENV = "intersection-v0"
# ENV = "racetrack-v0"
ENV_TYPE = "highway"
MODEL_TYPE = "dqn_default"

# Convert racetrack's ContinuousAction to discrete
racetrack_configs = RacetrackEnv.default_config()
discrete_action = {'type': 'DiscreteAction', 
                   'longitudinal': False, 
                   'lateral': True, 
                   'target_speeds': [0, 5, 10]}
racetrack_configs["observation"]["action"] = discrete_action
racetrack_configs["action"] = discrete_action

if __name__ == "__main__":
    # Create the environment
    if ENV_TYPE == "racetrack":
        env = gym.make(ENV, render_mode="rgb_array", config=racetrack_configs)
    else:
        env = gym.make(ENV, render_mode="rgb_array")
    obs, info = env.reset()

    # Create the model
    model = DQN(
        "MlpPolicy",
        env,
        # policy_kwargs=dict(net_arch=[256, 256]),
        # learning_rate=5e-4,
        # buffer_size=15000,
        # learning_starts=200,
        # batch_size=32,
        # gamma=0.8,
        # train_freq=1,
        # gradient_steps=1,
        # target_update_interval=50,
        verbose=1,
        tensorboard_log=f"results/{ENV_TYPE}_{MODEL_TYPE}/",
    )

    # Train the model
    model.learn(total_timesteps=int(2e5))
    model.save(f"results/{ENV_TYPE}_{MODEL_TYPE}/model")

    # # Run the trained model
    # model = DQN.load(f"results/{ENV_TYPE}_{MODEL_TYPE}/model", env=env)

    # for episode in range(10):
    #     done = truncated = False
    #     obs, info = env.reset()
    #     while not (done or truncated):
    #         action, _states = model.predict(obs, deterministic=True)
    #         obs, reward, done, truncated, info = env.step(action)
    #         env.render()
    # env.close()