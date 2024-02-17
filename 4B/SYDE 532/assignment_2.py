import math
import numpy as np
import matplotlib.pyplot as plt
import plotly.graph_objects as go

def Q2():
    def forward_euler(zn, delta, fz):
        (x, y) = zn
        (x_, y_) = fz(zn)
        return (x + delta * x_, y + delta * y_)
    
    def get_initial_point(k):
        x = 5 * math.cos(k * math.pi / 4)
        y = 5 * math.sin(k * math.pi / 4)
        return (x, y)
    
    def fz(z):
        x, y = z
        return (x + y, x - 2*y)
    
    delta = 0.01    # Step size
    steps = 100     # Number of steps
    for k in range(8):
        x, y = get_initial_point(k)
        xs = [x]
        ys = [y]
        for i in range(steps):
            x, y = forward_euler((x, y), delta, fz)
            xs.append(x)
            ys.append(y)

        # Plot the initial point and the trajectory
        plt.scatter(xs[0], ys[0], color='red', s=40, zorder=5)
        plt.plot(xs, ys)

    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('Phase Plot')
    plt.show()

def Q3a():
    def dzdt(s, theta, z):
        return s + z - theta * z**3

    # Part a) Let s = 0, generate a 2D array to store dzdt for a range of theta and z
    # Then plot the bifurcation as a contour plot
    s = 0
    theta = np.linspace(-5, 5, 500)
    z = np.linspace(-5, 5, 500)
    Theta, Z = np.meshgrid(theta, z)

    DZDT = dzdt(s, Theta, Z)

    plt.contour(Z, Theta, DZDT, levels=[0], colors='black')
    plt.xlabel('z')
    plt.ylabel('theta')
    plt.title('Bifurcation Plot')
    plt.grid(True)
    plt.show()

def Q3b():
    def dzdt(s, theta, z):
        return s + z - theta * z**3

    # Part b) Generate a 3D array to store dzdt for a range of s, theta, and z
    # Then plot the bifurcation as a 3D isosurface plot
    s = np.linspace(-5, 5, 50)
    theta = np.linspace(-5, 5, 50)
    z = np.linspace(-5, 5, 50)

    dzdts = np.zeros((len(s), len(theta), len(z)))

    for i in range(len(s)):
        for j in range(len(theta)):
            for k in range(len(z)):
                dzdts[i, j, k] = dzdt(s[i], theta[j], z[k])

    # Use meshgrid to correctly map coordinates
    S, Theta, Z = np.meshgrid(s, theta, z, indexing='ij')

    fig = go.Figure(data=go.Isosurface(
        x=S.flatten(),
        y=Theta.flatten(),
        z=Z.flatten(),
        value=dzdts.flatten(),
        isomin=-0.05,  # Adjusted to a slightly broader range
        isomax=0.05,   # Adjusted to a slightly broader range
        surface_count=2,  # Try showing multiple surfaces to capture more detail
        caps=dict(x_show=False, y_show=False, z_show=False)
    ))

    fig.update_layout(scene=dict(
                        xaxis_title='s',
                        yaxis_title='z',
                        zaxis_title='theta'),
                      title='Bifurcation Isosurface Plot')
    fig.show()

# Q2()
Q3a()
# Q3b()
