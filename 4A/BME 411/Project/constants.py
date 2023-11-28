import numpy as np

scale_factor = 265066 / 282510
min_per_hour = 60
hour_per_shift = 8

T = 480  # number of minutes in a shift
N = 9  # number of resource categories
M = 3  # number of shifts

# No. of resources, no. of patients, & time spent on each patient (min)
# from DOI:10.1080/20479700.2020.1763236 (A. Apornak et al., 2021)
x = np.array([[4, 4, 2],
              [8, 9, 4],
              [20, 20, 10],
              [1, 1, 1],
              [2, 2, 2],
              [1, 1, 1],
              [1, 1, 1],
              [2, 2, 2],
              [2, 2, 2]])

p = np.array([[35, 37, 24],
              [55, 56, 38],
              [60, 65, 45],
              [25, 28, 14],
              [27, 29, 18],
              [24, 22, 13],
              [32, 34, 23],
              [12, 10, 6],
              [15, 18, 9]])

t = np.array([[ 12,  14,  17],
                [  8,   9,   8],
                [ 21,  20,  14],    # [168, 172, 86] from the paper
                [ 10,  10,  10],
                [  4,   4,   4],
                [  7,   7,   7],
                [ 15,  15,  15],
                [ 30,  30,  30],
                [ 15,  15,  15]])

# Cost of each resource (average salary) (per hr)
c = np.array([[78, 78, 78],
              [73, 73, 73],
              [39, 39, 39],
              [41.21, 41.21, 41.21],
              [27.07, 27.07, 27.07],
              [34.45, 34.45, 34.45],
              [163, 163, 163],
              [78 + 33.56 + 48, 78 + 33.56 + 48, 78 + 33.56 + 48],
              [34.39, 34.39, 34.39]])

def scaling(arr, scale_factor):
    arr = arr*scale_factor
    arr = np.round(arr)
    arr = arr.astype(int)
    return arr

# Convert the number of patient arrivals to GRH
p = scaling(p, scale_factor)

# Convert salary per hour to salary per shift
c *= hour_per_shift

# Calculate waiting cost per minute
d = 30.68 / min_per_hour  # average salary per person in KW region (https://ca.talent.com/salary?job=waterloo+kitchener#:~:text=The%20average%20waterloo%20kitchener%20salary%20in%20Canada%20is%20%2459%2C819%20per,up%20to%20%24133%2C095%20per%20year.)
