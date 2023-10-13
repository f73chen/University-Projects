import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse
import numpy as np
import math
from matplotlib import cm
import matplotlib.lines as mlines
import matplotlib.patches as mpatches

# helpers
def plot_clusters(clusters, figsize=(8, 8)):
  figure, ax = plt.subplots(figsize=figsize)
  ax.axis('equal')
  cluster_names = [cluster.name for cluster in clusters]
  ax.set_title(f'Clusters {", ".join(cluster_names)} and their unit standard deviation contours',
              size=16) 
  ax.set_ylabel('x2',size=14)
  ax.set_xlabel('x1',size=14) 
  for cluster in clusters: 
    cluster.plot(ax)
    cluster.plot_unit_std_dev_contour(ax)
  ax.legend(fontsize=12)
  plt.show()

class Cluster:
    # leave default rand_state so that everyone uses the same data
    def __init__(self, name, N, mean, covariance, color, rand_state=42):
      self.name = name
      self.N = N
      self.mean = mean
      self.covariance = covariance
      self.color = color
      self.data = self.generate_2d_clusters(rand_state)
      self.eignvals, self.eignvects = np.linalg.eig(self.covariance)

    
    def generate_2d_clusters(self, rand_state):
      np.random.seed(rand_state)
      return np.random.multivariate_normal(self.mean, self.covariance, self.N).T
    
    def plot(self, ax):
      xs, ys = self.data
      ax.plot(xs, ys, '.', color=self.color, alpha=0.6,
              label=f'Cluster {self.name}')

    def plot_unit_std_dev_contour(self, ax):
      max_eignvals_idx = np.argmax(self.eignvals)
      rotation = self._angle(self.eignvects[max_eignvals_idx], (1,0))
      width = self.eignvals[max_eignvals_idx]**(1/2)*2
      height = self.eignvals[1-max_eignvals_idx]**(1/2)*2
      ellipse = Ellipse(xy=(self.mean[0], self.mean[1]), 
                        width=width, 
                        height=height, 
                        angle=rotation,
                        fill=False, 
                        color=self.color,
                        linewidth=2)
      ax.add_artist(ellipse)

    @classmethod
    def _angle(cls, unit_vect_1, unit_vect_2):
      return np.arccos(np.dot(unit_vect_1, unit_vect_2)) / (2 * math.pi) * 360

''' ######################### '''

# Generate & plot case 1 data
CLUSTER_A = Cluster(name='A', N=200, 
                    mean =      (3, 3), 
                    covariance=[[20, 5], 
                                [5, 10]],
                    color='r')
CLUSTER_B = Cluster(name='B', N=200, 
                    mean =      (9, 9), 
                    covariance=[[20, -5], 
                                [-5, 10]],
                    color='b')

def equation(x, y):
    return (101*x**2 + 9840*x - 294*x*y + 9*y**2 + 45000 - 2880*y)/1800

''' ######################### '''

def get_meshgrid(clusters, spacing = 0.5):
  x1_min = x1_max = clusters[0].data[0][0]
  x2_min = x2_max = clusters[0].data[1][0]
  for cluster in clusters:
    max = np.max(cluster.data, axis = 1)
    min = np.min(cluster.data, axis = 1)
    if max[0] > x1_max:
      x1_max = max[0]
    if max[1] > x2_max:
      x2_max = max[1]
    if min[0] < x1_min:
      x1_min = min[0]
    if min[1] < x2_min:
      x2_min = min[1]

  # Each [xx[i], yy[i]] is the coordinate of point i in the grid
  xx, yy = np.meshgrid(np.arange(x1_min - 1, x1_max + 1, spacing),
                       np.arange(x2_min - 1, x2_max + 1, spacing))
  
  # Reformat to list of coordinates
  return (xx, yy, np.zeros(len(xx.ravel())))

  # Find the general euclidean metric from point x to a cluster
# (x - ma).T * Sa-1 * (x - ma)
def general_euclidean_metric(x, cluster):
  # Note: 'true mean' just means the population mean, as opposed to the sample mean
  ma = cluster.mean
  return np.matmul(np.matmul((x - ma).T, np.linalg.inv(cluster.covariance)), (x - ma))

# Create decision boundary contour by classifying each point in a grid
def generate_GED_labels(clusters, spacing = 0.5):
  xx, yy, labels = get_meshgrid(clusters, spacing)
  grid = np.array([xx.ravel(), yy.ravel()]).T
  for idx, point in enumerate(grid):
    min_dist = general_euclidean_metric(point, clusters[0])
    for i in range(1, len(clusters)):
      dist = general_euclidean_metric(point, clusters[i])
      if dist < min_dist:
        min_dist = dist
        labels[idx] = i
  
  labels = labels.reshape(xx.shape[0], -1)
  return labels

#
def generate_equation_labels(clusters, spacing = 0.5, epsilon = 0.1):
    xx, yy, labels = get_meshgrid(clusters, spacing)
    Z = np.abs(equation(xx, yy))
    xx = xx[Z < epsilon]
    yy = yy[Z < epsilon]
    Z = Z[Z < epsilon]
    return xx, yy

# Plots clusters and decision boundaries based on labels
def plot_GED(clusters, spacing = 0.5, figsize=(8,8)):
  xx, yy, labels = get_meshgrid(clusters, spacing)
  labels_GED = generate_GED_labels(clusters, spacing)

  fig, ax = plt.subplots(figsize = figsize)
  ax.contour(xx, yy, labels_GED, linewidths = 1, levels = len(clusters)-1, linestyles = 'dashed', colors = 'blue')

  ax.axis('equal')
  cluster_names = [cluster.name for cluster in clusters]
  ax.set_title(f'Clusters {", ".join(cluster_names)} and their MED, GED decision boundaries',
              size=16) 
  ax.set_ylabel('x2',size=14)
  ax.set_xlabel('x1',size=14) 
  for cluster in clusters: 
    cluster.plot(ax)
    cluster.plot_unit_std_dev_contour(ax)

  handles, labels = ax.get_legend_handles_labels()
  GED_legend = mlines.Line2D([], [], color='blue', markersize=15, label='MICD Classifier')
  handles.append(GED_legend)
  labels.append('MICD Classifier')
  ax.legend(handles, labels, fontsize=12)

  x_c, y_c = generate_equation_labels(clusters, spacing, epsilon = 0.025)
  plt.scatter(x_c, y_c)

  plt.show()
 
plot_GED(clusters = [CLUSTER_A, CLUSTER_B], spacing = 0.05)