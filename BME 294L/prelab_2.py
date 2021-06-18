import math
import cmath
import numpy as np
import matplotlib.pyplot as plt

x = [100 * i for i in range(1, 11)]
x += [2000, 4000, 10000]
x = np.array(x)

def lowpass_cutoff(r, c):
    return 1 / (2 * np.pi * r * c)

def lowpass_gain(r, c, f):
    xc = 1 / (2 * np.pi * f * c)
    z = np.sqrt(r ** 2 + xc ** 2)
    return xc / z

def lowpass_potential_divider(vin, r, c, f):
    gain = lowpass_gain(r, c, f)
    rms = vin / (np.sqrt(2))
    return rms * gain

def lowpass_gain_db(r, c, f):
    gain = lowpass_gain(r, c, f)
    gain_db = 20 * np.log10(gain)
    return gain_db

def lowpass_phase_shift(r, c, f):
    shift = -np.arctan(2 * np.pi * f * r * c)
    shift_degrees = shift * 180 / np.pi
    return shift_degrees

# for f in x:
    # print(f"Vo p-p: {f} - {lowpass_potential_divider(1, 4700, 0.000000033, f)}")
    # print(f"Gain dB: {f} - {lowpass_gain_db(4700, 0.000000033, f)}")
    # print(f"Phase shift: {f} - {lowpass_phase_shift(4700, 0.000000033, f)}")
    # print(f"Cut-off frequency: {f} - {lowpass_cutoff(4700, 0.000000033)}")

'''
# Bode plot for linear gain in dB vs log freq
gain_db = lowpass_gain_db(4700, 0.000000033, x)
plt.plot(x, gain_db)
plt.xscale("log")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Gain (dB)")
plt.title("Linear Gain vs. Log Frequency")
plt.show()
'''

'''
# Bode plot for linear phase vs log freq
phase_shift = lowpass_phase_shift(4700, 0.000000033, x)
plt.plot(x, phase_shift)
plt.xscale("log")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase Shift (degrees)")
plt.title("Linear Phase Shift vs. Log Frequency")
plt.show()
'''