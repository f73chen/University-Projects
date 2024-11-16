import gymnasium as gym
import optuna
from option_critic import OptionCriticFeatures

# Define environment and training parameters
ENV_NAME = "CartPole-v1"  # Update as needed for other environments
RENDER_MODE = None  # Options: "rgb_array", "human"
TOTAL_TIMESTEPS = 100000
MODEL_TYPE = "oc"
ENV_TYPE = "cartpole"

def objective(trial):
    # Define hyperparameters to optimize
    num_options = trial.suggest_int("num_options", 2, 5)
    temperature = trial.suggest_float("temperature", 0.5, 2.0)
    epsilon_start = trial.suggest_float("epsilon_start", 0.8, 1.0)
    epsilon_min = trial.suggest_float("epsilon_min", 0.05, 0.2)
    epsilon_decay = trial.suggest_int("epsilon_decay", int(1e4), int(1e6), log=True)
    gamma = trial.suggest_float("gamma", 0.8, 0.99)
    termination_reg = trial.suggest_float("termination_reg", 0.001, 0.1, log=True)
    entropy_reg = trial.suggest_float("entropy_reg", 0.001, 0.1, log=True)
    learning_rate = trial.suggest_float("learning_rate", 1e-4, 1e-2, log=True)
    batch_size = trial.suggest_int("batch_size", 32, 128, step=32)
    critic_freq = trial.suggest_int("critic_freq", 10, 50, step=10)

    # Create environment
    env = gym.make(ENV_NAME)
    
    # Define the model
    oc = OptionCriticFeatures(
        env=env,
        num_options=num_options,
        device="cpu",
        temperature=temperature,
        epsilon_start=epsilon_start,
        epsilon_min=epsilon_min,
        epsilon_decay=epsilon_decay,
        gamma=gamma,
        termination_reg=termination_reg,
        entropy_reg=entropy_reg,
        learning_rate=learning_rate,
        batch_size=batch_size,
        critic_freq=critic_freq,
        target_update_freq=10,
        buffer_size=10000,
        verbose=0
    )
    
    # Train the model
    oc.learn(total_timesteps=TOTAL_TIMESTEPS)

    # Evaluate the model
    eval_env = gym.make(ENV_NAME)
    total_rewards = []
    for episode in range(5):
        obs, _ = eval_env.reset()
        done = truncated = False
        option = None
        option_termination = True
        episode_reward = 0
        while not (done or truncated):
            option, action, _, _ = oc.predict(obs, option, option_termination, deterministic=True)
            option_termination = oc.get_option_termination(obs, option)
            obs, reward, done, truncated, _ = eval_env.step(action)
            episode_reward += reward
        total_rewards.append(episode_reward)
    eval_env.close()

    mean_reward = sum(total_rewards) / len(total_rewards)
    return mean_reward


if __name__ == "__main__":
    # Optimize hyperparameters using Optuna
    TOTAL_TRIALS = 50
    study = optuna.create_study(direction="maximize", study_name=f"{MODEL_TYPE}_optimization", storage=f"sqlite:///results/{ENV_TYPE}_{MODEL_TYPE}/study.db", load_if_exists=True)
    # completed_trials = len(study.trials)
    # remaining_trials = max(TOTAL_TRIALS - completed_trials, 0)
    # print(f"Starting from trial {completed_trials}/{TOTAL_TRIALS}")
    # study.optimize(objective, n_trials=remaining_trials, show_progress_bar=True)

    # Display best hyperparameters
    print("Best hyperparameters:", study.best_params)

    # Save the best model
    env = gym.make(ENV_NAME, render_mode=RENDER_MODE)
    best_oc = OptionCriticFeatures(
        env=env,
        num_options=study.best_params["num_options"],
        device="cpu",
        temperature=study.best_params["temperature"],
        epsilon_start=study.best_params["epsilon_start"],
        epsilon_min=study.best_params["epsilon_min"],
        epsilon_decay=study.best_params["epsilon_decay"],
        gamma=study.best_params["gamma"],
        termination_reg=study.best_params["termination_reg"],
        entropy_reg=study.best_params["entropy_reg"],
        learning_rate=study.best_params["learning_rate"],
        batch_size=study.best_params["batch_size"],
        critic_freq=study.best_params["critic_freq"],
        target_update_freq=10,
        buffer_size=10000,
        tensorboard_log="results/cartpole_oc/"
    )
    best_oc.learn(total_timesteps=TOTAL_TIMESTEPS)
    # best_oc.save(f"results/{ENV_TYPE}_{MODEL_TYPE}/optimized_model")

    # Visualize results
    # optuna.visualization.plot_contour(study).show()
    # optuna.visualization.plot_slice(study).show()
    # optuna.visualization.plot_param_importances(study).show()
