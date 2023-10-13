import math
import cmath
import numpy as np
import matplotlib.pyplot as plt
import matplotlib

r2 = 500
r3 = 10000
c4 = 0.000047

x = np.linspace(0, 100, 100000)
y = r3 / (r2 + r3 + (r2 * r3 * c4 * x * 1j))
z = 20 * np.log10(np.absolute(y))
# print(z)

for x1, y1 in zip(x, z):
    if -3.0002 < y1 and y1 < -2.9998:
        print(f"Corner frequency: {x1} Hz")

plt.plot(x, z)
plt.xscale("log")
plt.title("Bode Plot")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Gain (dB)")
# plt.show()