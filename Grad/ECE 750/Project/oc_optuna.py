import gymnasium as gym
import highway_env
from highway_env.envs.intersection_env import IntersectionEnv
import optuna

from option_critic import OptionCriticFeatures
from fourrooms_env import Fourrooms

# Define environment and training parameters
ENV_NAME = "fourrooms"    # "CartPole-v1", "intersection-v1"
ENV_TYPE = "fourrooms"
RENDER_MODE = "human"  # "rgb_array", "human"
TOTAL_TIMESTEPS = int(1e5)
MODEL_TYPE = "oc"

def get_env():
    if ENV_TYPE == "fourrooms":
        env = Fourrooms()
        render_env = Fourrooms(render_mode=RENDER_MODE)
    elif ENV_TYPE == "intersection":
        intersection_config = IntersectionEnv.default_config()
        discrete_action = {'type': 'DiscreteAction', 
                        'longitudinal': False, 
                        'lateral': True, 
                        'target_speeds': [0, 5, 10]}
        intersection_config["observation"]["action"] = discrete_action
        intersection_config["action"] = discrete_action
        env = gym.make(ENV_NAME, config=intersection_config)
        render_env = gym.make(ENV_NAME, config=intersection_config, render_mode=RENDER_MODE)
    else:
        env = gym.make(ENV_NAME)
        render_env = gym.make(ENV_NAME, render_mode=RENDER_MODE)
        
    return env, render_env

def objective(trial):
    # Define hyperparameters to optimize
    num_options = trial.suggest_int("num_options", 2, 10)
    temperature = trial.suggest_float("temperature", 0.5, 2.0)
    epsilon_start = trial.suggest_float("epsilon_start", 0.8, 1.0)
    epsilon_min = trial.suggest_float("epsilon_min", 0, 0.2)
    epsilon_decay = trial.suggest_int("epsilon_decay", int(1e4), int(1e8), log=True)
    gamma = trial.suggest_float("gamma", 0.5, 0.99)
    tau = trial.suggest_float("tau", 0.8, 1.0)
    termination_reg = trial.suggest_float("termination_reg", 0.0001, 1000, log=True)
    entropy_reg = trial.suggest_float("entropy_reg", 0.001, 10000, log=True)
    hidden_size = trial.suggest_int("hidden_size", 8, 256, step=8)
    state_size = trial.suggest_int("state_size", 8, 256, step=8)
    hidden_size_2 = trial.suggest_int("hidden_size_2", 0, 256, step=8)
    hidden_size_Q = trial.suggest_int("hidden_size_Q", 0, 256, step=8)
    hidden_size_termination = trial.suggest_int("hidden_size_termination", 0, 256, step=8)
    hidden_size_policy = trial.suggest_int("hidden_size_policy", 0, 256, step=8)
    learning_rate = trial.suggest_float("learning_rate", 1e-7, 1e-2, log=True)
    batch_size = trial.suggest_int("batch_size", 32, 512, step=32)
    critic_freq = trial.suggest_int("critic_freq", 1, 200)
    target_update_freq = trial.suggest_int("target_update_freq", 1, 50)
    buffer_size = trial.suggest_int("buffer_size", 1000, 15000, step=1000)

    # Create environment
    env, _ = get_env()
    
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
        tau=tau,
        
        termination_reg=termination_reg,
        entropy_reg=entropy_reg,
        
        hidden_size=hidden_size,
        state_size=state_size,
        hidden_size_2=hidden_size_2,
        hidden_size_Q=hidden_size_Q,
        hidden_size_termination=hidden_size_termination,
        hidden_size_policy=hidden_size_policy,
        
        learning_rate=learning_rate,
        batch_size=batch_size,
        critic_freq=critic_freq,
        target_update_freq=target_update_freq,
        buffer_size=buffer_size,
        
        verbose=0
    )
    
    # Train the model
    oc.learn(total_timesteps=TOTAL_TIMESTEPS)

    # Set up evaluation environment
    total_rewards = []
    
    # Average across 20 episodes
    for episode in range(20):
        obs, _ = env.reset()
        done = truncated = False
        option = None
        option_termination = True
        episode_reward = 0
        while not (done or truncated):
            option, action, _, _ = oc.predict(obs, option, option_termination, testing=True)
            option_termination = oc.get_option_termination(obs, option)
            obs, reward, done, truncated, _ = env.step(action)
            episode_reward += reward
        total_rewards.append(episode_reward)
    env.close()
    
    total_rewards.sort()
    mean_reward = sum(total_rewards) / len(total_rewards)
    median_reward = total_rewards[len(total_rewards) // 2]
    print(f"Mean reward: {mean_reward}")
    print(f"Median reward: {median_reward}")
    # return min(mean_reward, median_reward)
    return mean_reward


if __name__ == "__main__":
    # Optimize hyperparameters using Optuna
    TOTAL_TRIALS = 400
    study = optuna.create_study(direction="maximize", study_name=f"{MODEL_TYPE}_optimization", storage=f"sqlite:///results/{ENV_TYPE}_{MODEL_TYPE}/study.db", load_if_exists=True)

    # Filter out failed trials by exporting successful trials to a new study
    successful_trials = [t for t in study.trials if t.state == optuna.trial.TrialState.COMPLETE]
    optuna.delete_study(study_name=f"{MODEL_TYPE}_optimization", storage=f"sqlite:///results/{ENV_TYPE}_{MODEL_TYPE}/study.db")
    study = optuna.create_study(direction="maximize", study_name=f"{MODEL_TYPE}_optimization", storage=f"sqlite:///results/{ENV_TYPE}_{MODEL_TYPE}/study.db")
    for trial in successful_trials:
        study.add_trial(trial)

    # Optimize until the total number of trials is reached
    completed_trials = len(study.trials)
    remaining_trials = max(TOTAL_TRIALS - completed_trials, 0)
    print(f"Starting from trial {completed_trials}/{TOTAL_TRIALS}")
    study.optimize(objective, n_trials=remaining_trials, show_progress_bar=True)

    # Display best hyperparameters
    print("Best hyperparameters:", study.best_params)

    # Visualize results
    optuna.visualization.plot_slice(study).show()
    optuna.visualization.plot_param_importances(study).show()

    # # Save the best model
    # env, render_env = get_env()
    # oc = OptionCriticFeatures(
    #     env=env,
    #     num_options=study.best_params["num_options"],
    #     device="cpu",
    #     temperature=study.best_params["temperature"],
    #     epsilon_start=study.best_params["epsilon_start"],
    #     epsilon_min=study.best_params["epsilon_min"],
    #     epsilon_decay=study.best_params["epsilon_decay"],
    #     gamma=study.best_params["gamma"],
    #     tau=study.best_params["tau"],
    #     termination_reg=study.best_params["termination_reg"],
    #     entropy_reg=study.best_params["entropy_reg"],
    #     hidden_size=study.best_params["hidden_size"],
    #     state_size=study.best_params["state_size"],
    #     hidden_size_2=study.best_params["hidden_size_2"],
    #     hidden_size_Q=study.best_params["hidden_size_Q"],
    #     hidden_size_termination=study.best_params["hidden_size_termination"],
    #     hidden_size_policy=study.best_params["hidden_size_policy"],
    #     learning_rate=study.best_params["learning_rate"],
    #     batch_size=study.best_params["batch_size"],
    #     critic_freq=study.best_params["critic_freq"],
    #     target_update_freq=study.best_params["target_update_freq"],
    #     buffer_size=study.best_params["buffer_size"],
    #     tensorboard_log=f"results/{ENV_TYPE}_{MODEL_TYPE}/",
    #     verbose=0
    # )
    # oc.learn(total_timesteps=TOTAL_TIMESTEPS)
    # oc.save(f"results/{ENV_TYPE}_{MODEL_TYPE}/best_model")
    
    # oc.load(f"results/{ENV_TYPE}_{MODEL_TYPE}/best_model")
    # for episode in range(10):
    #     done = truncated = False
    #     obs, info = render_env.reset()
    #     option = None
    #     option_termination = True
    #     while not (done or truncated):
    #         option, action, logp, entropy = oc.predict(obs, option, option_termination, testing=True)
    #         option_termination = oc.get_option_termination(obs, option)
    #         obs, reward, done, truncated, info = render_env.step(action)
    #         render_env.render()
    # render_env.close()
