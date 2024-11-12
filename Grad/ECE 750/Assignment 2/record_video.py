import gymnasium as gym
from stable_baselines3 import DQN, PPO
import highway_env
import os
import shutil
from PIL import Image
import subprocess

def record_frames(env, model, folder, episodes=1):
    frame_folder = folder + "/frames"
    video_folder = folder + "/videos"
    
    os.makedirs(frame_folder, exist_ok=True)

    for i in range(episodes):
        episode_dir = os.path.join(frame_folder, f"episode_{i}")
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
        video_path = f"{video_folder}/episode_{i}.mp4"
        os.makedirs(video_folder, exist_ok=True)
        ffmpeg_command = [
            "ffmpeg", "-framerate", "15", "-i", f"{episode_dir}/frame_%04d.png",
            "-c:v", "mpeg4", video_path
        ]
        subprocess.run(ffmpeg_command)

        # Clean up by removing the frame images after the video is created
        shutil.rmtree(episode_dir)
        print(f"Episode {i} video saved to {video_path} and frames deleted.")

# # Highway DQN
# env = gym.make("highway-fast-v0", render_mode="rgb_array")
# model = DQN.load("results/highway_dqn/model", env=env)
# record_frames(env, model, folder="results/highway_dqn", episodes=1)

# Intersection PPO
env = gym.make("intersection-v0", render_mode="rgb_array")
model = PPO.load("results/intersection_ppo/model", env=env)
record_frames(env, model, folder="results/intersection_ppo", episodes=1)

# # Racetrack PPO
# env = gym.make("racetrack-v0", render_mode="rgb_array")
# model = PPO.load("results/racetrack_ppo/model", env=env)
# record_frames(env, model, folder="results/racetrack_ppo", episodes=1)
