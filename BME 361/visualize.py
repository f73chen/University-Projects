import os
import csv
import argparse
import math
import pandas as pd

pd.options.mode.chained_assignment = None  # default='warn'

# Input CSV filename from the command line
parser = argparse.ArgumentParser()
parser.add_argument("-d", "--directory", type=str, help="Path to data directory")
parser.add_argument("-f", "--filename", type=str, help="CSV filename")
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

# Extract relevant columns
df_clean = df[['r0_1', 'r2_1', 'r6_1', 'r0_2', 'r2_2', 'r6_2']]
df_clean['x_com'] = 0
df_clean['y_com'] = 0

# Not sure why my x_com and y_com are different than the csv
# But mine matches manual calculation
nrows, ncols = df_clean.shape
for i in range(nrows):
    weighted_x, weighted_y, weight_tot = 0, 0, 0
    for j in range(ncols-2):
        weight = df_clean.iloc[i, j]
        if not math.isinf(weight):
            weighted_x += weight * x[j]
            weighted_y += weight * y[j]
            weight_tot += weight
    df_clean.loc[i, 'x_com'] = weighted_x / max(weight_tot, 0.1)
    df_clean.loc[i, 'y_com'] = weighted_y / max(weight_tot, 0.1)