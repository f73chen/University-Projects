import gymnasium as gym
from stable_baselines3 import DQN
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv
from stable_baselines3.common.monitor import Monitor
import optuna
import highway_env

from stable_baselines3.common.callbacks import EvalCallback
from stable_baselines3.common.evaluation import evaluate_policy

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning) 

ENV = "highway-fast-v0"
# ENV = "intersection-v0"
# ENV = "racetrack-v0"
ENV_TYPE = "highway-fast"
MODEL_TYPE = "dqn"

def objective(trial):
    # Define the hyperparameters to tune
    learning_rate = trial.suggest_float("learning_rate", 1e-5, 1e-3, log=True)
    gamma = trial.suggest_float("gamma", 0.9, 0.99)
    net_arch_type = trial.suggest_categorical("net_arch", ["tiny", "small", "medium"])

    net_arch = {"tiny": [64], "small": [64, 64], "medium": [256, 256]}[net_arch_type]
    target_update_interval = trial.suggest_categorical(
    "target_update_interval", [1, 1000, 5000, 10000]
)
    batch_size = trial.suggest_categorical("batch_size", [16, 32, 64, 100, 128, 256])
    buffer_size = trial.suggest_categorical("buffer_size", [int(1e4), int(1e5), int(5e4)])
    exploration_final_eps = trial.suggest_float("exploration_final_eps", 0, 0.15)
    exploration_fraction = trial.suggest_float("exploration_fraction", 0, 0.3)
    learning_starts = trial.suggest_categorical("learning_starts", [0, 1000, 5000])
    train_freq = trial.suggest_categorical("train_freq", [1, 4, 8, 16, 128])
    

    n_cpu = 8

    # Create environment
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


    eval_env = make_vec_env(ENV, n_envs=1, vec_env_cls=SubprocVecEnv)
    eval_callback = EvalCallback(eval_env, eval_freq=1000, n_eval_episodes=5, verbose=0)

    # Train the model
    model.learn(total_timesteps=int(1e5), callback=eval_callback)

    # Evaluate the model's mean reward
    mean_reward, _ = evaluate_policy(model, eval_env, n_eval_episodes=5, deterministic=True)

    return mean_reward


if __name__ == "__main__":
    # Optimize hyperparameters using Optuna
    TOTAL_TRIALS = 40
    

    study = optuna.create_study(direction="maximize", study_name=f"{MODEL_TYPE}_optimization", storage=f"sqlite:///results/{ENV_TYPE}_{MODEL_TYPE}/study.db", load_if_exists=True)
    completed_trials = len(study.trials)
    remaining_trials = max(TOTAL_TRIALS - completed_trials, 0)
    print(f"Starting from trial {completed_trials}/{TOTAL_TRIALS}")
    study.optimize(objective, n_trials=remaining_trials, show_progress_bar=True)

    # Display best hyperparameters
    print("Best hyperparameters:", study.best_params)

    # # Save the best model
    # env = make_vec_env(ENV, n_envs=8, vec_env_cls=SubprocVecEnv)
    # model = DQN(
    #     "MlpPolicy",
    #     env,
    #     policy_kwargs=dict(
    #         net_arch=net_arch[study.best_params["net_arch"]]
    #     ),
    #     batch_size=study.best_params["batch_size"],
    #     n_epochs=10,
    #     learning_rate=study.best_params["learning_rate"],
    #     gamma=study.best_params["gamma"],
    #     buffer_size=study.best_params["buffer_size"],
    #     learning_starts=study.best_params["learning_starts"],
    #     target_update_interval=study.best_params["target_update_interval"],
    #     exploration_final_eps=study.best_params["exploration_final_eps"],
    #     exploration_fraction=study.best_params["exploration_fraction"],
    #     train_freq=study.best_params["train_freq"],
    #     verbose=0,
    # )
    # model.learn(total_timesteps=int(1e5))
    # model.save(f"results/{ENV_TYPE}_{MODEL_TYPE}/optimized_model")

    # # Visualize results
    # optuna.visualization.plot_contour(study).show()
    # optuna.visualization.plot_slice(study).show()
    # optuna.visualization.plot_param_importances(study).show()
