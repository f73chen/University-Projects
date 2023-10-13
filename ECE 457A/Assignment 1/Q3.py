import numpy as np

def fitness_func(x):
    return np.linalg.norm(x) / (np.log10(abs(x[0])) + 1) + abs(x[2])

def pso(X, V, alpha, iter):
    Xs = []
    all_fitness = []

    for i in range(iter):
        Xs += X.tolist()
        fitness = [fitness_func(x) for x in X]
        all_fitness += fitness
        local_best = np.argmax(fitness)
        global_best = np.argmax(all_fitness)

        print(f"Fitness {i}: {np.round(fitness, 3)}")
        print(f"Local best: {local_best}, {np.round(X[local_best], 3)}")
        print(f"Global best: {global_best}, {np.round(Xs[global_best], 3)}\n")
    
        X_new = np.zeros(X.shape)
        V_new = np.zeros(V.shape)
        for j in range(len(X)):
            V_new[j] = alpha[0] * V[j] + alpha[1] * (X[local_best] - X[j]) + alpha[2] * (Xs[global_best] - X[j])
            X_new[j] = X[j] + V_new[j]
        X = X_new
        V = V_new
        print(X)
        print(V)

X = np.array([[1, 2, -1, 1], [-1, 1, 1, -1], [2, -1, 2, 0]])
V = np.array([[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]])
alpha = np.array([0.1, 0.1, 0.1])

pso(X, V, alpha, 3)