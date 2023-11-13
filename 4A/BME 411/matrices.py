import numpy as np

scale_factor = 265066 / 282510

# Scale matrices from PAPER
x = np.array([4, 4, 2],
             [8, 9, 4],
             [20, 20, 10],
             [1, 1, 1],
             [2, 2, 2],
             [1, 1, 1],
             [1, 1, 1],
             [2, 2, 2],
             [2, 2, 2]) * scale_factor

p = np.array([35, 37, 24],
             [55, 56, 38],
             [60, 65, 45],
             [25, 28, 14],
             [27, 29, 18],
             [24, 22, 13],
             [32, 34, 23],
             [12, 10, 6],
             [15, 18, 9]) * scale_factor

t = np.array([12, 14, 17],
             [8, 9, 8],
             [168, 172, 86],
             [10, 10, 10],
             [4, 4, 4],
             [7, 7, 7],
             [15, 15, 15],
             [30, 30, 30],
             [15, 15, 15]) * scale_factor

# Cast to int
x = np.ceil(x)
x = x.astype(int)

p = np.ceil(p)
p = p.astype(int)

t = np.ceil(t)
t = t.astype(int)

print(x)
print(p)
print(t)
