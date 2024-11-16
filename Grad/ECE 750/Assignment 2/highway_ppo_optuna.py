import gymnasium as gym
from stable_baselines3 import PPO
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.vec_env import SubprocVecEnv
from stable_baselines3.common.monitor import Monitor
import optuna
import highway_env

from stable_baselines3.common.callbacks import EvalCallback
from stable_baselines3.common.evaluation import evaluate_policy

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning) 

# ENV = "highway-fast-v0"
ENV = "intersection-v0"
# ENV = "racetrack-v0"
ENV_TYPE = "intersection"
MODEL_TYPE = "ppo"

def objective(trial):
    # Define the hyperparameters to tune
    learning_rate = trial.suggest_float("learning_rate", 1e-5, 1e-3, log=True)
    gamma = trial.suggest_float("gamma", 0.8, 0.99)
    pi_hidden_units = trial.suggest_int("pi_hidden_units", 64, 512, step=64)
    vf_hidden_units = trial.suggest_int("vf_hidden_units", 64, 512, step=64)
    n_steps = trial.suggest_int("n_steps", 256, 2048, step=256)

    n_cpu = 8
    batch_size = 64

    # Create environment
    env = make_vec_env(ENV, n_envs=n_cpu, vec_env_cls=SubprocVecEnv)

    # Define the model
    model = PPO(
        "MlpPolicy",
        env,
        policy_kwargs=dict(net_arch=dict(pi=[pi_hidden_units, pi_hidden_units], vf=[vf_hidden_units, vf_hidden_units])),
        n_steps=n_steps // n_cpu,
        batch_size=batch_size,
        n_epochs=10,
        learning_rate=learning_rate,
        gamma=gamma,
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
    # completed_trials = len(study.trials)
    # remaining_trials = max(TOTAL_TRIALS - completed_trials, 0)
    # print(f"Starting from trial {completed_trials}/{TOTAL_TRIALS}")
    # study.optimize(objective, n_trials=remaining_trials, show_progress_bar=True)

    # Display best hyperparameters
    print("Best hyperparameters:", study.best_params)

    # Save the best model
    env = make_vec_env(ENV, n_envs=8, vec_env_cls=SubprocVecEnv)
    model = PPO(
        "MlpPolicy",
        env,
        policy_kwargs=dict(
            net_arch=dict(
                    pi=[study.best_params["pi_hidden_units"], study.best_params["pi_hidden_units"]],
                    vf=[study.best_params["vf_hidden_units"], study.best_params["vf_hidden_units"]],
            )
        ),
        n_steps=study.best_params["n_steps"] // 8,
        batch_size=64,
        n_epochs=10,
        learning_rate=study.best_params["learning_rate"],
        gamma=study.best_params["gamma"],
        verbose=0,
    )
    # model.learn(total_timesteps=int(1e5))
    # model.save(f"results/{ENV_TYPE}_{MODEL_TYPE}/optimized_model")

    # Visualize results
    optuna.visualization.plot_contour(study).show()
    optuna.visualization.plot_slice(study).show()
    optuna.visualization.plot_param_importances(study).show()
