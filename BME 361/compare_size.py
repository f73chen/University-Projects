import os
import pandas as pd

datapath = os.path.dirname(os.path.abspath(__file__)) + r'\data' 

# each key holds filename, 10-index range of stable observations 
info = {
    'candace': [r'\standard_candace_1-ss38.5.csv', [460, 469]],
    'christina': [r'\standard_christina_1-ss405.csv', [680, 689]],
    'eunice': [r'\standard_eunice_1-ss37.csv', [1686, 1695]],
    'fenglin': [r'\standard_grace_2-ss37.csv', [675, 684]]
}

# normalize sensor averages given dataframe
def normalize(data):
    sensor_names = ['r0_1', 'r2_1', 'r6_1', 'r0_2', 'r2_2', 'r6_2']
    averages = []
    for name in sensor_names: 
        averages.append(sum(data[name][info[person][1][0]:info[person][1][1]])/10)
    averages = [(avg - min(averages)) / (max(averages) - min(averages)) for avg in averages]
    return averages

# get normalized sensor readings for each person
for person in info:
    data = pd.read_csv(datapath + info[person][0])
    normalized_data = normalize(data)
    print(normalized_data)
    