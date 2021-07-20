import numpy as np
import matplotlib.pyplot as plt
import simpleaudio as sa
from scipy.io.wavfile import read, write
from scipy import signal
from scipy.signal import resample, sosfilt, butter

basePath = "C:/Users/16479/Downloads/phase_one/"
fileNames = ["Single Female.wav",
             "Single Male.wav",
             "Dual Male Female.wav",
             "Coffee Shop.wav"]

# Task 4 - Function for designing a bandpass filter
def bandpass(signal, fs, fLow, fHigh, order):
    ''' Applies a bandpass filter to a signal and returns the filtered signal
    Args:
        signal: signal to filter
        fs: sampling frequency
        fLow: lower cutoff frequency
        fHigh: higher cutoff frequency
        order: order of filter
    '''
    nyq = fs * 0.5
    low = fLow / nyq
    high = fHigh / nyq
    #b, a = butter(order, [low, high], 'bandpass', analog=False)
    sos = butter(order, [low, high], 'bandpass', analog=False, output='sos')
    return sosfilt(sos, signal)
    
# Task 5 - Function to filter the sounds 
def filter(signal, fs, fLow, fHigh, order):
    return bandpass(signal, fs, fLow, fHigh, order)

# Task 6 - Function to plot the filtered signal
def plot(path, fileName):
    # read file and get signal
    file = read(path + fileName)
    samplingRate = file[0]
    arr = np.array(file[1])
    # if stereo then convert to mono
    if len(arr[0]) > 1:
        arr = np.sum(arr, axis = 1)
    # scale and cast
    arr = np.int16(arr/np.max(np.abs(arr)) * 32767)
    # plot signal 
    time = np.linspace(0, len(arr)-1, len(arr))
    plt.plot(time, filter(arr, samplingRate, 100.0, 8000.0, 5))
    plt.title('Signal for: ' + fileName)
    plt.xlabel('Time (ms)')
    plt.ylabel('Amplitude')
    plt.show()

# Using Tasks 4-6 to plot the filtered signals
for fileName in fileNames:
    plot(basePath, fileName)
