import random
import numpy as np
from tqdm import tqdm
from typing import Tuple, List, Callable, Optional
import matplotlib.pyplot as plt

DIMENSION = 2
X_INITIAL = None
MAX_ITER = 500
CONVERGENCE_THRESHOLD = 0.001

# Schwefel cost function from the tutorial
def schwefel(x: List[float]) -> float:
    d = len(x)
    f = 418.9829 * d
    for xi in x:
        f = f - (xi * np.sin(np.sqrt(np.abs(xi))))
    return f

# Local search from the tutorial
def local_search(cost_function: Callable, max_itr: int, convergence_threshold: float, 
                 x_initial: Optional[np.array] = None, x_range: Optional[List[List[float]]] = None, hide_progress_bar: Optional[bool] = False) -> Tuple[np.array, float, List[np.array], List[float]]:
    # Set the x_initial
    if x_initial is None:
        x_initial = [random.uniform(x_range[i][0], x_range[i][1]) for i in range(len(x_range))]

    x_current = x_initial
    cost_current = cost_function(x_current)

    x_history = [x_current]
    cost_history = [cost_current]

    # Create a tqdm progress bar
    if not hide_progress_bar:
        progress_bar = tqdm(total=max_itr, desc='Iterations')

    convergence = False
    itr = 0
    while not convergence:
        # Generate neighboring solutions
        x_neighbor = [random.gauss(x, 0.1) for x in x_current]
        x_neighbor = bound_solution_in_x_range(x=x_neighbor, x_range=x_range)
        cost_neighbor = cost_function(x_neighbor)

        # Accept the neighbor if it has lower cost
        if cost_neighbor < cost_current:
            x_current = x_neighbor
            cost_current = cost_neighbor
            if (cost_current < convergence_threshold) or (itr >= max_itr):
                convergence = True

        x_history.append(x_current)
        cost_history.append(cost_current)

        # Update the tqdm progress bar
        if not hide_progress_bar:
            progress_bar.update(1)  # Increment the progress bar by 1 unit
        itr += 1
    
    # progress_bar.close()

    # Get the best solution
    best_cost_index = np.argmin(cost_history)
    best_x = x_history[best_cost_index]
    best_cost = cost_history[best_cost_index]

    return best_x, best_cost, x_history, cost_history    

# Visualization from the tutorial
def plot_results(best_x: np.array, best_cost: float, x_history: List[np.array], cost_history: List[float], cost_function: Callable, x_range: Optional[List[List[float]]] = None) -> None:
    x1_history = [x[0] for x in x_history]
    x2_history = [x[1] for x in x_history]

    # Create a 3D plot of the optimization landscape
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    # Generate a grid of x1 and x2 values for plotting the surface
    if x_range is not None:
        x1_range = np.linspace(x_range[0][0], x_range[0][1], 500)
        x2_range = np.linspace(x_range[1][0], x_range[1][1], 500)
    else:
        x1_range = np.linspace(min(x1_history) - 2, max(x1_history) + 2, 500)
        x2_range = np.linspace(min(x2_history) - 2, max(x2_history) + 2, 500)
    X1, X2 = np.meshgrid(x1_range, x2_range)

    # Initialize an empty array to store the cost values
    Z = np.zeros_like(X1)

    # Calculate the cost for each combination of X1 and X2
    for i in range(X1.shape[0]):
        for j in range(X1.shape[1]):
            Z[i][j] = cost_function([X1[i][j], X2[i][j]])

    # Plot the surface
    ax.plot_surface(X1, X2, Z, cmap='viridis', alpha=0.7)

    # Plot the optimization path
    ax.plot(x1_history, x2_history, cost_history, marker='o', linestyle='-', color='red', label='Optimization path')
    ax.plot(best_x[0], best_x[1], best_cost, marker='o', linestyle='-', color='blue', label='Best solution')

    ax.set_xlabel('x1')
    ax.set_ylabel('x2')
    ax.set_zlabel('Cost')
    ax.set_title('Cost function and optimization')
    plt.legend()
    plt.show()

    # Calculate the extent for the 2D heatmap plot based on the actual range of the data
    x1_min, x1_max = min(x1_range), max(x1_range)
    x2_min, x2_max = min(x2_range), max(x2_range)

    # Create a 2D heatmap plot
    plt.figure(figsize=(8, 6))
    plt.imshow(Z, extent=(x1_min, x1_max, x2_min, x2_max), origin='lower', cmap='viridis', interpolation='bilinear')
    plt.colorbar(label='Cost')
    plt.xlabel('x1')
    plt.ylabel('x2')
    plt.title('Cost function and optimization')
    plt.grid(True)

    # Overlay the optimization path on the heatmap as red dots
    plt.plot(x1_history, x2_history, c='red', marker='o', linestyle='-', label='Optimization path')
    plt.plot(best_x[0], best_x[1], c='blue', marker='o', linestyle='-', label='Best solution')
    plt.legend()
    plt.show()




x_range = [[-500, 500] for i in range(DIMENSION)]


best_x, best_cost, x_history, cost_history = local_search(cost_function=schwefel, max_itr=MAX_ITER,
                                                                                    convergence_threshold=CONVERGENCE_THRESHOLD,
                                                                                    x_initial=X_INITIAL, x_range=x_range)
        
if len(best_x) == 2: 
    # If the dimensionality is 2, visualize the results.
    plot_results(best_x=best_x, best_cost=best_cost,
                            x_history=x_history, cost_history=cost_history,
                            cost_function=schwefel, x_range=x_range)