import pickle
from scipy.signal import find_peaks
import numpy as np
import matplotlib.pyplot as plt

''' QUESTION 1 '''
# a)
x = np.linspace(10, 20, 6)

# b)
total = 0
for element in x:
    total += element

# c)
def find_total(x):
    total = 0
    for element in x:
        total += element
    return total

# d)
y = x[1:5]

''' QUESTION 2 '''
# a)
with open('106m.pkl', 'rb') as f:
    signal = np.array(pickle.load(f))/200

# b)
time = np.linspace(0, 5, 1801)
signal_5 = signal[:1801]
plt.plot(time, signal_5, label = "Full Signal")
plt.xlabel("Time (s)")
plt.ylabel("ECG Signal (mV)")

# c)
peak_x = np.array(find_peaks(signal_5, prominence = 0.2)[0])
peak_y = [signal_5[i] for i in peak_x]
peak_x = peak_x/360
plt.scatter(peak_x, peak_y, c='blue', marker='x', label = "P, R, T")

# d)
def t_waves(signal):
    prt = np.array(find_peaks(signal, prominence = 0.2)[0])
    r = np.array(find_peaks(signal, prominence = 0.2, height = 6.25)[0])
    
    t_x = []
    for i in range(len(prt)):
        if i > 0:
            if prt[i-1] in r:    # If the previous peak was an R wave
                t_x.append(prt[i])      # The the current peak must be a T wave
                continue
        if i < len(prt) - 2:
            if prt[i+2] in r:    # If two waves after will be an R wave
                t_x.append(prt[i])      # The the current peak must be a T wave
    
    t_y = np.array([signal[i] for i in t_x])
    t_x = np.array(t_x)/360
    return t_x, t_y

t_x, t_y = t_waves(signal_5)
plt.scatter(t_x, t_y, c='red', marker='x', label = "T")
plt.show()

# e)
plt.clf()
time_20 = np.linspace(20, 25, 1801)
signal_20 = signal[7200:9001]
t_x, t_y = t_waves(signal_20)

plt.plot(time_20, signal_20, label = "Full Signal")
plt.scatter(t_x+20, t_y, c='red', marker='x', label = "T")
plt.xlabel("Time (s)")
plt.ylabel("ECG Signal (mV)")
plt.show()