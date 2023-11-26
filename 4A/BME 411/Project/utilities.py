import numpy as np

def scaling(arr, scale_factor):
    arr = arr*scale_factor
    arr = np.round(arr)
    arr = arr.astype(int)
    return arr


def hour_to_minutes(arr, hr_to_min):
    arr = arr/hr_to_min
    return arr
