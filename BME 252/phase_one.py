import wave
from scipy.io.wavfile import read
from pydub import AudioSegment
import numpy as np
import matplotlib.pyplot as plt

basePath = "C:/Users/User/Desktop/School/2B/BME 252/Project Phase 1/"
fileNames = [basePath + "Single Female.wav",
             basePath + "Single Male.wav",
             basePath + "Dual Male Female.wav",
             basePath + "Coffee Shop.wav"]

for file in fileNames:
    # Get sampling rate
    wav = AudioSegment.from_wav(file)
    print(f"Filename: {file}")
    print(f"Sampling rate: {wav.frame_rate}")   # Sampling rate: 44100

    # Convert to single-channel array
    arr = read(file)[1]
    nChannels = len(arr[0])
    print(f"# Channels: {nChannels}")           # Stereo (2)
    if nChannels > 1:
        arr = [pair[0] + pair[1] for pair in arr]



    print()