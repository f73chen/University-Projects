import numpy as np
from sklearn import datasets
import matplotlib.pyplot as plt

iris = datasets.load_iris()
data = iris['data']
target = iris['target']

manual_x = np.linspace(0, 4, 1000)
manual_y = manual_x * -0.5 + 2
plt.plot(manual_x, manual_y)

def est_classify():
    setosa_idx = []
    for i in range(len(data[:,2])):
        if data[:,3][i] < data[:,2][i] * -0.5 + 2:
            setosa_idx.append(int(i))
    return [data[i,2] for i in setosa_idx], [data[i,3] for i in setosa_idx], [target[i] for i in setosa_idx]

setosa_f1, setosa_f2, setosa_target = est_classify()
plt.scatter(data[:,2], data[:,3], marker='.', c=target)
plt.scatter(setosa_f1, setosa_f2, marker='*', c=setosa_target)

plt.show()