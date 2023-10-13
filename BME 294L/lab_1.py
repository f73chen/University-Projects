import math
import cmath
import numpy as np
import matplotlib.pyplot as plt

x = [100 * i for i in range(1, 11)]
x += [2000, 4000, 10000]
x = np.array(x)

xn = np.linspace(1, 1000000, 1000001)

vom = [983.4, 968.9, 942.8, 907.5, 875.0,
      835.3, 793.2, 745.8, 716.7, 682.7,
      431.5, 238.8, 96.91]
vo = np.array(vom)/1000

phase_shift = np.array([-5.652, -11.10, -16.36, -21.35, -26.09,
               -30.50, -34.44, -38.09, -41.38, -44.38,
               -62.89, -75.79, -84.15])

def amp_to_db(vi, vo):
    gain = np.divide(vo, vi)
    gain_db = 20 * np.log10(gain)
    return gain_db

gain_db = amp_to_db(1, vo)
# for v, g in zip(vo, gain_db):
#     print(f"vo: {v} V - gain_db: {g}")

# '''
plt.plot(x, gain_db)
plt.xlim([1, 1000000])
plt.xscale("log")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Gain (dB)")
plt.title("Linear Gain vs. Log Frequency")
plt.show()
# '''
'''
plt.plot(x, phase_shift)
plt.ylim([-90, 0])
plt.xlim([1, 1000000])
plt.xscale("log")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase Shift (degrees)")
plt.title("Linear Phase Shift vs. Log Frequency")
plt.show()
'''