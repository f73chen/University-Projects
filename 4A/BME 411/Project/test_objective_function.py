import numpy as np

import objective_function as obj

def test_arrival_times():
    expected_arrival_times = [0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240, 264, 288, 312, 336, 360, 384, 408, 432, 456, 480, 960]

    T = 480    # number of minutes in a shift
    N = 1      # number of resource categories
    M = 3      # number of shifts
    p =  np.array([[20, 1, 1]])
    
    arrival_times = obj.calculate_arrival_times(N=N, M=M, T=T, p=p)
    assert arrival_times[0] == expected_arrival_times

def test_wait_time_1():
    # wait time: 88 min
    test_t_1 = np.array([[ 12,  14,  17],
                         [  8,   9,   8],
                         [ 50,  50,  20],
                         [ 10,  10,  10],
                         [  4,   4,   4],
                         [  7,   7,   7],
                         [ 15,  15,  15],
                         [ 30,  30,  30],
                         [ 15,  15,  15]])
    wait_time = obj.simulation(t=test_t_1)
    assert wait_time == 88

    # wait time: 0 min
    test_t_2 = np.array([[ 12,  14,  17],
                         [  8,   9,   8],
                         [ 30,  30,  20],
                         [ 10,  10,  10],
                         [  4,   4,   4],
                         [  7,   7,   7],
                         [ 15,  15,  15],
                         [ 30,  30,  30],
                         [ 15,  15,  15]])
    wait_time = obj.simulation(t=test_t_2)
    assert wait_time == 0

    # wait time: inf
    test_t_3 = np.array([[ 12,  14,  17],
                         [  8,   9,   8],
                         [ 30,  30,  30],
                         [ 10,  10,  10],
                         [  4,   4,   4],
                         [  7,   7,   7],
                         [ 15,  15,  15],
                         [ 30,  30,  30],
                         [ 15,  15,  15]])
    wait_time = obj.simulation(t=test_t_3)
    assert np.isinf(wait_time)

    # wait time > 480 min
    test_t_4 = np.array([[ 12,  14,  17],
                         [  8,   9,   8],
                         [ 80,  80,  20],
                         [ 10,  10,  10],
                         [  4,   4,   4],
                         [  7,   7,   7],
                         [ 15,  15,  15],
                         [ 30,  30,  30],
                         [ 15,  15,  15]])
    wait_time = obj.simulation(t=test_t_4)
    assert wait_time > 480

    # with researched values https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6371290/
    test_t_5 = np.array([[ 12,  14,  17],
                         [  8,   9,   8],
                         [ 21,  20,  14],
                         [ 10,  10,  10],
                         [  4,   4,   4],
                         [  7,   7,   7],
                         [ 15,  15,  15],
                         [ 30,  30,  30],
                         [ 15,  15,  15]])
    wait_time = obj.simulation(t=test_t_5)
    assert wait_time == 0

def test_wait_time_2():
    # Number of resources == number of patients and no overflow
    T = 480  
    N = 3  
    M = 3  
    p = np.array([[4, 4, 4],
                    [8, 8, 8],
                    [20, 20, 20]])
    x = p.copy()
    t = np.array([[15, 15, 15],
                    [10, 10, 10],
                    [5, 5, 5]])

    arrival_times = obj.calculate_arrival_times(N=N, M=M, T=T, p=p)
    wait_time = obj.simulation(x=x, t=t, N=N, arrival_times=arrival_times)
    assert wait_time == 0

def test_wait_time_3():
    # Number of resources == number of patients and no overflow
    T = 480  
    N = 3  
    M = 3  
    p = np.array([[10, 10, 7],
                [1, 1, 1],
                [1, 1, 1]])
    x = np.array([[9, 9, 9],
                [1, 1, 1],
                [1, 1, 1]])
    t = np.array([[49, 49, 49],
                [1, 1, 1],
                [1, 1, 1]])

    arrival_times = obj.calculate_arrival_times(N=N, M=M, T=T, p=p)
    wait_time = obj.simulation(x=x, t=t, N=N, arrival_times=arrival_times)
    assert wait_time == 96
    
def test_objective_function():
    N = 9
    M = 3
    T = 480
    x = np.ones((9, 3)).astype(int)
    t = np.ones((9, 3))
    c = np.ones((9, 3)) * 100
    p = np.ones((9, 3))
    d = 1
    arrival_times = obj.calculate_arrival_times(N=N, M=M, T=T, p=p)
    
    obj_cost, not_served, wait_exceeded = obj.calculate_objective(x=x, t=t, c=c, p=p, d=d, N=N, M=M, T=T, arrival_times=arrival_times)
    assert not not_served
    assert not wait_exceeded
    assert obj_cost == 2700