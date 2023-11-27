import numpy as np

import objective_function as of

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
    wait_time = of.simulation(t=test_t_1)
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
    wait_time = of.simulation(t=test_t_2)
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
    wait_time = of.simulation(t=test_t_3)
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
    wait_time = of.simulation(t=test_t_4)
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
    wait_time = of.simulation(t=test_t_5)
    assert wait_time == 0

def test_wait_time_2():
    # Number of resources == number of patients and no overflow
    T_test = 480  
    N_test = 3  
    M_test = 3  
    p_test = np.array([[4, 4, 4],
                       [8, 8, 8],
                       [20, 20, 20]])
    x_test = p_test.copy()
    t_test = np.array([[15, 15, 15],
                       [10, 10, 10],
                       [5, 5, 5]])

    ARRIVAL_TIMES_test = [[] for _ in range(N_test)]
    for i in range(N_test):
        for j in range(M_test):
            padded_time = j*T_test
            interval = int(np.floor(T_test/p_test[i][j]))
            ARRIVAL_TIMES_test[i].extend(padded_time + np.arange(0, interval*p_test[i][j], interval))

    wait_time = of.simulation(x_test, t_test, N=N_test, arrival_times=ARRIVAL_TIMES_test)
    assert wait_time == 0

def test_arrival_times():
    expected_arrival_times =[0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240, 264, 288, 312, 336, 360, 384, 408, 432, 456]

    T_test = 480  # number of minutes in a shift
    N_test = 9  # number of resource categories
    M_test = 3  # number of shifts

    p_test =  np.array([[20, 0, 0],
                        [0, 0, 0]])
    ARRIVAL_TIMES_test = [[] for _ in range(N_test)]
    for i in range(N_test):
        for j in range(M_test):
            padded_time = j * T_test
            interval = int(np.floor(T_test / p_test[0][0]))
            ARRIVAL_TIMES_test[i].extend(j * T_test + np.arange(0, interval * p_test[0][0], interval))
            
    assert ARRIVAL_TIMES_test[0][:20] == expected_arrival_times