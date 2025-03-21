import gymnasium as gym
from stable_baselines3 import DQN
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv
from stable_baselines3.common.monitor import Monitor
import optuna
import os

import highway_env
from highway_env.envs.racetrack_env import RacetrackEnv

from stable_baselines3.common.callbacks import EvalCallback
from stable_baselines3.common.evaluation import evaluate_policy

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning) 

# ENV = "highway-fast-v0"
# ENV = "intersection-v0"
ENV = "racetrack-v0"
ENV_TYPE = "racetrack"
MODEL_TYPE = "dqn"

# Convert racetrack's ContinuousAction to discrete
racetrack_configs = RacetrackEnv.default_config()
discrete_action = {'type': 'DiscreteAction', 
                   'longitudinal': False, 
                   'lateral': True, 
                   'target_speeds': [0, 5, 10]}
racetrack_configs["observation"]["action"] = discrete_action
racetrack_configs["action"] = discrete_action

net_arch_mapping = {"tiny": [64], "small": [64, 64], "medium": [256, 256]}

def objective(trial):
    # Define the hyperparameters to tune
    learning_rate = trial.suggest_float("learning_rate", 1e-5, 1e-3, log=True)
    gamma = trial.suggest_float("gamma", 0.8, 0.99)
    net_arch_type = trial.suggest_categorical("net_arch", ["tiny", "small", "medium"])
    net_arch = net_arch_mapping[net_arch_type]
    target_update_interval = trial.suggest_categorical("target_update_interval", [1, 1000, 5000, 10000])
    batch_size = trial.suggest_categorical("batch_size", [16, 32, 64, 96, 128])
    buffer_size = trial.suggest_categorical("buffer_size", [5000, 7500, 10000, 30000, 50000, 70000])
    exploration_final_eps = trial.suggest_float("exploration_final_eps", 0, 0.15)
    exploration_fraction = trial.suggest_float("exploration_fraction", 0, 0.3)
    learning_starts = trial.suggest_categorical("learning_starts", [0, 500, 1000, 2500, 4000, 5000])
    train_freq = trial.suggest_categorical("train_freq", [1, 4, 8, 16, 32])
    
    n_cpu = 8

    # Create environment
    if ENV_TYPE == "racetrack":    
        env = make_vec_env(ENV, n_envs=n_cpu, vec_env_cls=SubprocVecEnv, env_kwargs={"config": racetrack_configs})
    else:
        env = make_vec_env(ENV, n_envs=n_cpu, vec_env_cls=SubprocVecEnv)

    # Define the model
    model = DQN(
        "MlpPolicy",
        env,
        policy_kwargs=dict(net_arch=net_arch),
        learning_rate=learning_rate,
        buffer_size=buffer_size,
        learning_starts=learning_starts,
        batch_size=batch_size,
        gamma=gamma,
        target_update_interval=target_update_interval,
        exploration_final_eps=exploration_final_eps,
        exploration_fraction=exploration_fraction,
        train_freq=train_freq,
        verbose=0,
    )

    if ENV_TYPE == "racetrack":    
        eval_env = make_vec_env(ENV, n_envs=n_cpu, vec_env_cls=SubprocVecEnv, env_kwargs={"config": racetrack_configs})
    else:
        eval_env = make_vec_env(ENV, n_envs=n_cpu, vec_env_cls=SubprocVecEnv)
        
    eval_callback = EvalCallback(eval_env, eval_freq=1000, n_eval_episodes=20, verbose=0)

    # Train the model
    model.learn(total_timesteps=int(1e5), callback=eval_callback)

    # Evaluate the model's mean reward
    mean_reward, _ = evaluate_policy(model, eval_env, n_eval_episodes=20, deterministic=True)

    return mean_reward


if __name__ == "__main__":
    # Optimize hyperparameters using Optuna
    TOTAL_TRIALS = 100
    
    study = optuna.create_study(direction="maximize", study_name=f"{MODEL_TYPE}_optimization", storage=f"sqlite:///results/{ENV_TYPE}_{MODEL_TYPE}/study.db", load_if_exists=True)
    
    # completed_trials = len(study.trials)
    # remaining_trials = max(TOTAL_TRIALS - completed_trials, 0)
    # print(f"Starting from trial {completed_trials}/{TOTAL_TRIALS}")
    # study.optimize(objective, n_trials=remaining_trials, show_progress_bar=True)

    # # Display best hyperparameters
    # print("Best hyperparameters:", study.best_params)

    # # Define the evaluation environment
    # if ENV_TYPE == "racetrack":
    #     eval_env = make_vec_env(ENV, n_envs=1, vec_env_cls=SubprocVecEnv, env_kwargs={"config": racetrack_configs})
    # else:
    #     eval_env = make_vec_env(ENV, n_envs=1, vec_env_cls=SubprocVecEnv)
        
    # # Define the save path for the best model
    # save_path = f"results/{ENV_TYPE}_{MODEL_TYPE}"
    # os.makedirs(save_path, exist_ok=True)

    # # Create the evaluation callback
    # eval_callback = EvalCallback(
    #     eval_env,
    #     best_model_save_path=save_path,
    #     log_path=save_path,
    #     eval_freq=10000,
    #     deterministic=True,
    #     render=False,
    #     verbose=1
    # )
     
    # # Create and train the model
    # if ENV_TYPE == "racetrack":    
    #     env = make_vec_env(ENV, n_envs=8, vec_env_cls=SubprocVecEnv, env_kwargs={"config": racetrack_configs})
    # else:
    #     env = make_vec_env(ENV, n_envs=8, vec_env_cls=SubprocVecEnv)
       
    # model = DQN(
    #     "MlpPolicy",
    #     env,
    #     policy_kwargs=dict(net_arch=net_arch_mapping[study.best_params["net_arch"]]),
    #     learning_rate=study.best_params["learning_rate"],
    #     buffer_size=study.best_params["buffer_size"],
    #     learning_starts=study.best_params["learning_starts"],
    #     batch_size=study.best_params["batch_size"],
    #     gamma=study.best_params["gamma"],
    #     target_update_interval=study.best_params["target_update_interval"],
    #     exploration_final_eps=study.best_params["exploration_final_eps"],
    #     exploration_fraction=study.best_params["exploration_fraction"],
    #     train_freq=study.best_params["train_freq"],
    #     verbose=1,
    #     tensorboard_log=f"results/{ENV_TYPE}_{MODEL_TYPE}/"
    # )

    # # Train the model and save the best one
    # model.learn(total_timesteps=int(2e5), callback=eval_callback)

    # # Visualize results
    optuna.visualization.plot_contour(study).show()
    optuna.visualization.plot_slice(study).show()
    optuna.visualization.plot_param_importances(study).show()