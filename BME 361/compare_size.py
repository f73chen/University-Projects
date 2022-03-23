import os
import pandas as pd
import numpy as np
import math

datapath = os.path.dirname(os.path.abspath(__file__)) + r'\data' 

# each key holds filename, 10-index range of stable observations 
info = {
    'candace': [r'\standard_candace_1-ss38.5.csv', [460, 469]],
    'christina': [r'\standard_christina_1-ss405.csv', [680, 689]],
    'eunice': [r'\standard_eunice_1-ss37.csv', [1686, 1695]],
    'fenglin': [r'\standard_grace_2-ss37.csv', [675, 684]]
}

# function for normalizing sensor averages given dataframe
def normalize(data):
    sensor_names = ['r0_1', 'r2_1', 'r6_1', 'r0_2', 'r2_2', 'r6_2']
    averages = []
    for name in sensor_names: 
        averages.append(sum(data[name][info[person][1][0]:info[person][1][1]])/10)
    averages = [float("%0.3f" % (avg / sum(averages))) for avg in averages]
    return averages

# function for adding rmse values to info dictionary
def compute_rmse():
    standard = info['christina'][2]
    for person in info:
        vals = info[person][2]
        info[person].append(math.sqrt(np.square(np.subtract(standard, vals)).mean()))


# add normalized sensor readings to info dictionary
for person in info:
    data = pd.read_csv(datapath + info[person][0])
    info[person].append(normalize(data))

# add rmse to info dictionary
compute_rmse()
print(info)
    