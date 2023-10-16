import random
import numpy as np
from tqdm import tqdm
from typing import Tuple, List, Callable, Optional
import matplotlib.pyplot as plt
import matplotlib.patches as patches

DIMENSION = 2
LOCAL_ITER = 500
CONVERGENCE_THRESHOLD = 0.001
DOMAIN = [-500, 500]

# Schwefel cost function from the tutorial
def schwefel(x: List[float]) -> float:
    d = len(x)
    f = 418.9829 * d
    for xi in x:
        f = f - (xi * np.sin(np.sqrt(np.abs(xi))))
    return f

# Helper function from the tutorial
def bound_solution_in_x_range(x: List[float], x_range: List[List[float]]) -> List[float]:
    for j in range(len(x)):
        if x[j] < x_range[j][0]:
            x[j] = x_range[j][0]
        elif x[j] > x_range[j][1]:
            x[j] = x_range[j][1]
    return x

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
            if cost_current - cost_neighbor < convergence_threshold:
                convergence = True
            x_current = x_neighbor
            cost_current = cost_neighbor

        if itr >= max_itr:
            convergence = True

        x_history.append(x_current)
        cost_history.append(cost_current)

        # Update the tqdm progress bar
        if not hide_progress_bar:
            progress_bar.update(1)  # Increment the progress bar by 1 unit
        itr += 1

    # Get the best solution
    best_cost_index = np.argmin(cost_history)
    best_x = x_history[best_cost_index]
    best_cost = cost_history[best_cost_index]

    return best_x, best_cost, x_history, cost_history    

# Visualization from the tutorial
def plot_results(best_x: np.array, best_cost: float, x_history: List[np.array], cost_history: List[float], cost_function: Callable, x_range: Optional[List[List[float]]] = None, N = []) -> None:
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
    fig, ax = plt.subplots(figsize=(8, 6))
    img = ax.imshow(Z, extent=(x1_min, x1_max, x2_min, x2_max), origin='lower', cmap='viridis', interpolation='bilinear')
    fig.colorbar(img, ax=ax, label='Cost')
    ax.set_xlabel('x1')
    ax.set_ylabel('x2')
    ax.set_title('Cost function and optimization')
    ax.grid(True)

    # Overlay the optimization path on the heatmap as red dots
    ax.plot(x1_history, x2_history, c='red', marker='o', linestyle='-', label='Optimization path')
    ax.plot(best_x[0], best_x[1], c='blue', marker='o', linestyle='-', label='Best solution')
    ax.legend()
    plt.show()

    # Plot each neighbourhood around x
    for neighbourhood in N:
        x1, x2, y1, y2 = neighbourhood[0][0], neighbourhood[0][1], neighbourhood[1][0], neighbourhood[1][1]
        rect = patches.Rectangle((x1, y1), x2-x1, y2-y1, linewidth=2, edgecolor='green', facecolor=(0, 1, 0, 0.2))
        ax.add_patch(rect)
    plt.show()

# Place n neighbourhoods in D-dimensional space randomly around x
def partition_neighbourhoods(x, n, size, radius):
    N = []

    # For each neighbourhood
    for i in range(n):
        # Generate a random point on the D-dimensional sphere
        coords = np.random.randn(DIMENSION)
        norm_coords = radius * coords / np.linalg.norm(coords)

        # Center the sphere on x
        p = x + norm_coords

        # Create a box around the point
        box = [[max(DOMAIN[0], p[d] - size), min(DOMAIN[1], p[d] + size)] for d in range(DIMENSION)]
        
        # Check if at least part of the box is in the domain
        in_domain = True
        for d in range(DIMENSION):
            if box[d][0] > DOMAIN[1] or box[d][1] < DOMAIN[0]:
                in_domain = False

        # If valid, add it to the list of neighbourhoods
        if in_domain:
            box = np.round(np.array(box), 3)
            N.append(box)

    return N

# Plot the neighbourhoods around x
def visualize_neighbourhoods(x, neighbourhoods):
    fig, ax = plt.subplots()

    # Plot the outer bounding box
    bounding_box = patches.Rectangle((DOMAIN[0], DOMAIN[0]), DOMAIN[1]-DOMAIN[0], DOMAIN[1]-DOMAIN[0], linewidth=2, edgecolor='red', facecolor='none')
    ax.add_patch(bounding_box)

    # Plot the initial solution x
    ax.plot(*x, 'bo')

    # Plot each neighbourhood around x
    for neighbourhood in neighbourhoods:
        x1, x2, y1, y2 = neighbourhood[0, 0], neighbourhood[0, 1], neighbourhood[1, 0], neighbourhood[1, 1]
        rect = patches.Rectangle((x1, y1), x2-x1, y2-y1, linewidth=2, edgecolor='green', facecolor=(0, 1, 0, 0.2))
        ax.add_patch(rect)
    
    ax.set_title('Neighbourhoods around x')
    ax.set_aspect('equal')
    plt.show()

# Checks if a point is within a bounding box
def in_box(x, box):
    for dim in range(len(x)):
        if x[dim] < box[dim][0] or x[dim] > box[dim][1]:
            return False
    return True

# Implement variable neighbourhood search
def VNS(n, size, radius, x_initial=None):
    if not x_initial:
        # Initial (naive) local search
        best_x, best_cost, x_history, cost_history = local_search(cost_function=schwefel, max_itr=LOCAL_ITER,
                                                                convergence_threshold=CONVERGENCE_THRESHOLD, 
                                                                x_range=[DOMAIN for i in range(DIMENSION)],
                                                                hide_progress_bar=True)
        all_best_x = best_x
        all_best_cost = best_cost    
        all_x_history = x_history
        all_cost_history = cost_history
    else:
        best_x = x_initial
        all_best_x = x_initial
        all_best_cost = schwefel(x_initial)
        all_x_history = []
        all_cost_history = []

    # Create the neighbourhoods
    N = partition_neighbourhoods(best_x, n, size, radius)

    if DIMENSION == 2 and not x_initial:
        visualize_neighbourhoods(best_x, N)

    # Use the initial solution if in neighbourhood, else randomly generate a starting point
    local_x = [best_x if in_box(best_x, Ni) else [np.random.uniform(Ni[d, 0], Ni[d, 1]) for d in range(DIMENSION)] for Ni in N]
    local_cost = [schwefel(x) for x in local_x]

    # Perform local search on each neighbourhood until all of them are checked
    i = 0
    while i < len(N):
        best_x, best_cost, x_history, cost_history = local_search(cost_function=schwefel, max_itr=LOCAL_ITER,
                                                                  convergence_threshold=CONVERGENCE_THRESHOLD, 
                                                                  x_initial=local_x[i], x_range=N[i], hide_progress_bar=True)
        all_x_history += x_history
        all_cost_history += cost_history

        # Update the local best for each neighbourhood if x is in neighbourhood
        for j in range(len(N)):
            if best_cost < local_cost[j] and in_box(best_x, N[j]):
                local_x[j] = best_x
                local_cost[j] = best_cost

        # Restart the search if a better solution is found, else move on to the next neighbourhood
        if best_cost < all_best_cost - CONVERGENCE_THRESHOLD:
            all_best_cost = best_cost
            all_best_x = best_x
            i = 0
        else:
            i += 1

    return all_best_x, all_best_cost, all_x_history, all_cost_history, N

# Implement generalized neighbourhood search
def GNS(layers, n, size, radius):
    # Initial (naive) local search
    best_x, best_cost, x_history, cost_history = local_search(cost_function=schwefel, max_itr=LOCAL_ITER,
                                                              convergence_threshold=CONVERGENCE_THRESHOLD, 
                                                              x_range=[DOMAIN for i in range(DIMENSION)],
                                                              hide_progress_bar=True)
    x_initial = best_x
    all_best_x = best_x
    all_best_cost = best_cost    
    all_x_history = x_history
    all_cost_history = cost_history
    all_N = []

    # Call each layer of VNS
    for k in range(layers):
        best_x, best_cost, x_history, cost_history, N = VNS(n=n[k], size=size[k], radius=radius[k], x_initial=x_initial)
        if best_cost < all_best_cost:
            all_best_x = best_x
            all_best_cost = best_cost
        all_x_history += x_history
        all_cost_history += cost_history
        all_N += N

    if DIMENSION == 2:
        visualize_neighbourhoods(x_initial, all_N)

    return all_best_x, all_best_cost, all_x_history, all_cost_history, all_N

# Call VNS and plot results
best_x, best_cost, x_history, cost_history, N = VNS(n=8, size=50, radius=100)
print(f"VNS best x: {best_x}, best cost: {best_cost}")

if DIMENSION == 2:
    plot_results(best_x=best_x, best_cost=best_cost,
                x_history=x_history, cost_history=cost_history,
                cost_function=schwefel, x_range=[DOMAIN for i in range(DIMENSION)], N=N)

# Call GNS and plot results
best_x, best_cost, x_history, cost_history, N = GNS(layers=3, n=[8, 10, 14], size=[45, 60, 75], radius=[100, 250, 400])
print(f"GNS best x: {best_x}, best cost: {best_cost}")

if DIMENSION == 2:
    plot_results(best_x=best_x, best_cost=best_cost,
                x_history=x_history, cost_history=cost_history,
                cost_function=schwefel, x_range=[DOMAIN for i in range(DIMENSION)], N=N)