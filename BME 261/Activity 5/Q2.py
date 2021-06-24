import numpy as np
from sklearn import datasets
import matplotlib.pyplot as plt
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import confusion_matrix

bc = datasets.load_breast_cancer()
data = bc['data']
target = bc['target']

test_idx = np.random.randint(0, len(target), round(len(target)/5))
train_idx = np.setdiff1d(range(len(target)), test_idx)

test_x = [data[i, :] for i in test_idx]
test_y = [target[i] for i in test_idx]
train_x = [data[i, :] for i in train_idx]
train_y = [target[i] for i in train_idx]

nb = KNeighborsClassifier(n_neighbors=5)
nb.fit(train_x, train_y)
pred = nb.predict(test_x)
mat = confusion_matrix(test_y, pred)
print(mat)

# Classifier with n_neighbours = 1 performed worse than n_neighbours = 5
# Therefore, generalization to unseen data is better if there are more neighbours (less overfitting)