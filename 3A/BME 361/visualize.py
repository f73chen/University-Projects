import os
import csv
import argparse
import math
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg, NavigationToolbar2Tk)
from tkinter import *

pd.options.mode.chained_assignment = None  # default='warn'

# Input CSV filename from the command line
parser = argparse.ArgumentParser()
parser.add_argument("-d", "--directory", type=str, help="Path to data directory", default="data")
parser.add_argument("-f", "--filename", type=str, help="CSV filename")
parser.add_argument("-l", "--height", type=int, help="Window height", default=625)
parser.add_argument("-w", "--width", type=int, help="Window width", default=450)
parser.add_argument("-fs", "--fsr_scale", type=float, help="FSR circle scaling factor", default=2/3)
parser.add_argument("-cs", "--com_scale", type=float, help="COM circle scaling factor", default=1/6)
args = parser.parse_args()

# Load the CSV as a DataFrame
parent_path = os.path.dirname(os.path.abspath(__file__))
csv_path = os.path.join(parent_path, args.directory, args.filename)
print(f"Reading from: {csv_path}")
df = pd.read_csv(csv_path)

# Sensor locations
#    r0_1	r2_1	r6_1	r0_2	r2_2	r6_2
x = [0,     -1,     4,      3,      1,      -2]
y = [0,     14,     13,     8,      16,     19]
height = args.height
width = args.width
fsr_factor = args.fsr_scale
com_factor = args.com_scale

# Extract relevant columns
# r0_1 etc. are already the converted masses/weights
df_clean = df[['r0_1', 'r2_1', 'r6_1', 'r0_2', 'r2_2', 'r6_2']]
df_clean['x_com'] = 0
df_clean['y_com'] = 0
df_clean['weight_tot'] = 0

# Not sure why my x_com and y_com are different than the csv
# But mine matches manual calculation
nrows, ncols = df_clean.shape
for i in range(nrows):
    weighted_x, weighted_y, weight_tot = 0, 0, 0
    for j in range(ncols-3):
        weight = df_clean.iloc[i, j]
        if not math.isinf(weight):
            weighted_x += weight * x[j]
            weighted_y += weight * y[j]
            weight_tot += weight
    df_clean.loc[i, 'x_com'] = weighted_x / max(weight_tot, 0.1)
    df_clean.loc[i, 'y_com'] = weighted_y / max(weight_tot, 0.1)
    df_clean.loc[i, 'weight_tot'] = weight_tot

# Update the Tkinter plot
def plot(idx):
    # Get current FSR weights and center of mass (COM)
    idx = int(idx)
    weights = df_clean.iloc[idx, :6]
    com = df_clean.iloc[idx, 6:]

    # Reset the plot area
    ax.clear()
    ax.set_xlim((-7, 9))
    ax.set_ylim((-5, 24))

    # Add circles representing the pressures
    for i, weight in enumerate(weights):
        circle = plt.Circle((x[i], y[i]), weight*fsr_factor, color='black')
        ax.add_patch(circle)
    circle = plt.Circle((com[0], com[1]), com[2]*com_factor, color='green')
    ax.add_patch(circle)

    # Load the Matplotlib graph in Tkinter
    canvas.draw()
    canvas.get_tk_widget().pack()

# Instantiate the Tkinter window
window = Tk()
window.title("Foot Pressure")
window.geometry(f'{width}x{height}')

# Instantiate the plotting canvas
fig, ax = plt.subplots()
figheight, figwidth = height/625*8, width/450*4.5
fig.set_figheight(figheight)
fig.set_figwidth(figwidth)
canvas = FigureCanvasTkAgg(fig, master=window)

# Add the frame selector
frame = Scale(master=window, from_=0, to=nrows-1, length=int(width*0.9), orient=HORIZONTAL, command=plot)
frame.pack()

window.mainloop()