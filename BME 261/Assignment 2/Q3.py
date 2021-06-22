import pickle
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# a)
with open('peak-data.pkl', 'rb') as f:
    data = pickle.load(f)
    # for k, v in peaks.items():
    #     print(k, len(v))
    ecg = data['ecg']
    indices = data['indices']
    labels = data['labels']

idx = []
values = []
for j in range(3):
    idx.append(np.array([indices[i] for i in range(len(labels)) if labels[i] == j+1]))
    values.append(np.array([ecg[i] for i in idx[j]]))
    
plt.plot(ecg)
plt.scatter(idx[0], values[0], c='red')
plt.scatter(idx[1], values[1], c='green')
plt.scatter(idx[2], values[2], c='blue')
plt.show()

# b)
