import gymnasium as gym
from stable_baselines3 import DQN

import highway_env
from highway_env.envs.racetrack_env import RacetrackEnv

TRAIN = False

if __name__ == "__main__":
    # Create the environment
    configs = RacetrackEnv.default_config()
    discrete_action = {'type': 'DiscreteAction', 
                       'longitudinal': False, 
                       'lateral': True, 
                       'target_speeds': [0, 5, 10]}
    configs["observation"]["action"] = discrete_action
    configs["action"] = discrete_action
    
    env = gym.make("racetrack-v0", render_mode="rgb_array", config=configs)
    obs, info = env.reset()
    print(env.unwrapped.config)

    # Create the model
    model = DQN(
        "MlpPolicy",
        env,
        policy_kwargs=dict(net_arch=[256, 256]),
        learning_rate=5e-4,
        buffer_size=15000,
        learning_starts=200,
        batch_size=32,
        gamma=0.8,
        train_freq=1,
        gradient_steps=1,
        target_update_interval=50,
        verbose=1,
        tensorboard_log="results/highway_dqn/",
    )

    # Train the model
    if TRAIN:
        model.learn(total_timesteps=int(1e5))
        # model.save("results/racetrack_dqn/model")
        del model

    # Run the trained model
    # model = DQN.load("results/racetrack_dqn/model", env=env)

    for episode in range(10):
        done = truncated = False
        obs, info = env.reset()
        while not (done or truncated):
            action, _states = model.predict(obs, deterministic=True)
            obs, reward, done, truncated, info = env.step(action)
            env.render()
    env.close()