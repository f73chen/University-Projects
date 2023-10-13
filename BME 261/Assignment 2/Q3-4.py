import pickle
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

''' QUESTION 3 '''

# a)
with open('peak-data.pkl', 'rb') as f:
    data = pickle.load(f)
    # for k, v in peaks.items():
    #     print(k, len(v))
    ecg = data['ecg']
    indices = data['indices']
    labels = data['labels']

# b)
idx = []
f1 = []
f2 = []
for j in range(3):
    idx_label = [indices[i] for i in range(len(labels)) if labels[i] == j+1]
    idx.append(idx_label)

    # Feature 1: raw height of peaks
    f1.append([ecg[i] for i in idx_label])

    # Feature 3: average of heights 30-45 samples later
    # For P, this is the R wave. For T, it's low-amplitude noise
    f2.append([np.average(ecg[i+30:i+45]) for i in idx_label])
    
# c)
plt.scatter(f1[0], f2[0], c='red', label="Label 1")
plt.scatter(f1[1], f2[1], c='green', label="Label 2")
plt.scatter(f1[2], f2[2], c='blue', label="Label 3")
plt.xlabel("Raw Height of Peaks")
plt.ylabel("Average of Heights 30-45 Samples Later")
plt.legend()
# plt.show()

''' QUESTION 4 '''

# a)
plt.axvline(x=0.95)

# b)
plt.clf()

plt.axvline(x=0.95)
plt.scatter(f1[0], f2[0], c='red', label="Class 1")
f1_12 = f1[1]+f1[2]
f2_12 = f2[1]+f2[2]
print(len(f1[1]))
print(len(f1_12))
plt.scatter(f1_12, f2_12, c='blue', label="Class 2")
plt.xlabel("Raw Height of Peaks")
plt.ylabel("Average of Heights 30-45 Samples Later")
plt.legend()
plt.show()