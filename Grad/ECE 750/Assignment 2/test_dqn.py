import gymnasium as gym
from gymnasium.wrappers import RecordVideo
from stable_baselines3 import DQN

import highway_env

import subprocess
import os

class CustomRecordVideo(RecordVideo):
    def _save_video(self, episode_path):
        """Override the default _save_video method to use a custom ffmpeg command."""
        # Define paths and check if frames are present
        video_file_path = os.path.join(self.video_folder, f"{self.name_prefix}-episode-{self.episode_id}.mp4")
        frame_pattern = os.path.join(episode_path, "frame_%04d.png")
        
        # Custom ffmpeg command without the 'preset' argument
        ffmpeg_command = [
            "ffmpeg", "-framerate", "15", "-i", frame_pattern,
            "-c:v", "mpeg4", video_file_path
        ]
        
        # Run the command to create the video
        subprocess.run(ffmpeg_command, check=True)
        
        # Clean up frames after saving the video
        for file_name in os.listdir(episode_path):
            file_path = os.path.join(episode_path, file_name)
            os.remove(file_path)
        os.rmdir(episode_path)
        print(f"Saved video: {video_file_path}")


TRAIN = False

if __name__ == "__main__":
    # Create the environment
    env = gym.make("highway-fast-v0", render_mode="rgb_array")
    obs, info = env.reset()

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
        tensorboard_log="highway_dqn/",
    )

    # Train the model
    if TRAIN:
        model.learn(total_timesteps=int(2e4))
        model.save("highway_dqn/model")
        del model

    # Run the trained model and record video
    model = DQN.load("highway_dqn/model", env=env)
    env = CustomRecordVideo(
        env, video_folder="highway_dqn/videos", episode_trigger=lambda e: True
    )
    env.unwrapped.config["simulation_frequency"] = 15  # Higher FPS for rendering

    for videos in range(10):
        done = truncated = False
        obs, info = env.reset()
        while not (done or truncated):
            # Predict
            action, _states = model.predict(obs, deterministic=True)
            # Get reward
            obs, reward, done, truncated, info = env.step(action)
            # Render
            env.render()
    env.close()