import gymnasium as gym
from stable_baselines3 import DQN
import highway_env  # noqa: F401
import os
import shutil
from PIL import Image
import subprocess

def record_frames(env, model, frame_path, episodes=1):
    os.makedirs(frame_path, exist_ok=True)

    for i in range(episodes):
        episode_dir = os.path.join(frame_path, f"episode_{i}")
        os.makedirs(episode_dir, exist_ok=True)
        
        obs, info = env.reset()
        done = truncated = False
        frame_count = 0

        while not (done or truncated):
            action, _states = model.predict(obs, deterministic=True)
            obs, reward, done, truncated, info = env.step(action)
            frame = env.render()  # Assuming render_mode="rgb_array"

            # Save the frame as an image
            img = Image.fromarray(frame)
            img.save(f"{episode_dir}/frame_{frame_count:04d}.png")
            frame_count += 1

        # Generate video from frames using ffmpeg
        video_path = f"highway_dqn/videos/episode_{i}.mp4"
        os.makedirs("highway_dqn/videos", exist_ok=True)
        ffmpeg_command = [
            "ffmpeg", "-framerate", "15", "-i", f"{episode_dir}/frame_%04d.png",
            "-c:v", "mpeg4", video_path
        ]
        subprocess.run(ffmpeg_command)

        # Clean up by removing the frame images after the video is created
        shutil.rmtree(episode_dir)
        print(f"Episode {i} video saved to {video_path} and frames deleted.")

# Initialize environment and load model
env = gym.make("highway-fast-v0", render_mode="rgb_array")
model = DQN.load("highway_dqn/model", env=env)

# Save frames and convert them to videos
record_frames(env, model, "highway_dqn/frames")
