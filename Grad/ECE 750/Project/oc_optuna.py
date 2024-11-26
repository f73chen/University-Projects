import gymnasium as gym
import optuna
from option_critic import OptionCriticFeatures

# Define environment and training parameters
ENV_NAME = "CartPole-v1"
RENDER_MODE = "human"  # "rgb_array", "human"
TOTAL_TIMESTEPS = int(1e5)
ENV_TYPE = "cartpole"
MODEL_TYPE = "oc"

def objective(trial):
    # Define hyperparameters to optimize
    num_options = trial.suggest_int("num_options", 2, 6)
    temperature = trial.suggest_float("temperature", 0.5, 1.5)
    epsilon_start = trial.suggest_float("epsilon_start", 0.8, 1.0)
    epsilon_min = trial.suggest_float("epsilon_min", 0, 0.2)
    epsilon_decay = trial.suggest_int("epsilon_decay", int(1e4), int(1e6), log=True)
    gamma = trial.suggest_float("gamma", 0.8, 0.99)
    tau = trial.suggest_float("tau", 0.8, 1.0)
    termination_reg = trial.suggest_float("termination_reg", 0.001, 0.1, log=True)
    entropy_reg = trial.suggest_float("entropy_reg", 0.001, 0.2, log=True)
    hidden_size = trial.suggest_int("hidden_size", 16, 128, step=16)
    state_size = trial.suggest_int("state_size", 16, 128, step=16)
    learning_rate = trial.suggest_float("learning_rate", 1e-5, 1e-2, log=True)
    batch_size = trial.suggest_int("batch_size", 32, 256, step=32)
    critic_freq = trial.suggest_int("critic_freq", 10, 100, step=10)
    target_update_freq = trial.suggest_int("target_update_freq", 5, 20, step=5)
    buffer_size = trial.suggest_int("buffer_size", 1000, 10000, step=1000)

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
        epsilon_test=0.05,
        gamma=gamma,
        tau=tau,
        termination_reg=termination_reg,
        entropy_reg=entropy_reg,
        hidden_size=hidden_size,
        state_size=state_size,
        learning_rate=learning_rate,
        batch_size=batch_size,
        critic_freq=critic_freq,
        target_update_freq=target_update_freq,
        buffer_size=buffer_size,
        verbose=0,
        testing=False
    )
    
    # Train the model
    oc.learn(total_timesteps=TOTAL_TIMESTEPS)

    # Set up evaluation environment
    eval_env = gym.make(ENV_NAME)
    total_rewards = []
    oc.testing = True
    
    # Average across 20 episodes
    for episode in range(20):
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
    
    total_rewards.sort()
    median_reward = total_rewards[len(total_rewards) // 2]
    return median_reward


if __name__ == "__main__":
    # Optimize hyperparameters using Optuna
    TOTAL_TRIALS = 200
    study = optuna.create_study(direction="maximize", study_name=f"{MODEL_TYPE}_optimization", storage=f"sqlite:///results/{ENV_TYPE}_{MODEL_TYPE}/study.db", load_if_exists=True)
    # completed_trials = len(study.trials)
    # remaining_trials = max(TOTAL_TRIALS - completed_trials, 0)
    # print(f"Starting from trial {completed_trials}/{TOTAL_TRIALS}")
    # study.optimize(objective, n_trials=remaining_trials, show_progress_bar=True)

    # Display best hyperparameters
    print("Best hyperparameters:", study.best_params)

    # # Visualize results
    # optuna.visualization.plot_slice(study).show()
    # optuna.visualization.plot_param_importances(study).show()

    # Save the best model
    env = gym.make(ENV_NAME, render_mode=RENDER_MODE)
    oc = OptionCriticFeatures(
        env=env,
        num_options=study.best_params["num_options"],
        device="cpu",
        temperature=study.best_params["temperature"],
        epsilon_start=study.best_params["epsilon_start"],
        epsilon_min=study.best_params["epsilon_min"],
        epsilon_decay=study.best_params["epsilon_decay"],
        epsilon_test=0.05,
        gamma=study.best_params["gamma"],
        tau=study.best_params["tau"],
        termination_reg=study.best_params["termination_reg"],
        entropy_reg=study.best_params["entropy_reg"],
        hidden_size=study.best_params["hidden_size"],
        state_size=study.best_params["state_size"],
        learning_rate=study.best_params["learning_rate"],
        batch_size=study.best_params["batch_size"],
        critic_freq=study.best_params["critic_freq"],
        target_update_freq=study.best_params["target_update_freq"],
        buffer_size=study.best_params["buffer_size"],
        tensorboard_log=f"results/{ENV_TYPE}_{MODEL_TYPE}/",
        testing=False
    )
    # oc.learn(total_timesteps=TOTAL_TIMESTEPS)
    # oc.save(f"results/{ENV_TYPE}_{MODEL_TYPE}/best_model")
    
    oc.load(f"results/{ENV_TYPE}_{MODEL_TYPE}/best_model")
    oc.testing = True
    for episode in range(10):
        done = truncated = False
        obs, info = env.reset()
        option = None
        option_termination = True
        while not (done or truncated):
            option, action, logp, entropy = oc.predict(obs, option, option_termination, deterministic=True)
            option_termination = oc.get_option_termination(obs, option)
            obs, reward, done, truncated, info = env.step(action)
            env.render()
    env.close()
