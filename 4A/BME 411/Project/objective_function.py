import numpy as np
import constants

T = constants.T  # number of minutes in a shift
N = constants.N  # number of resource categories
M = constants.M  # number of shifts
x = constants.x  # staff availability matrix
t = constants.t  # time for resource matrix
c = constants.c  # cost of resource matrix
d = constants.d  # cost of waiting 1 minute

ARRIVAL_TIMES = constants.ARRIVAL_TIMES


def simulation_by_shift(served_times, i, j, xij, tij, oij, T=T, arrival_times=ARRIVAL_TIMES):
    """
    :param i: index of resource [0, 8]
    :param j: index of shift [0, 2]
    :param x: number of staff assigned to resource i in shift j
    :param t: number of minutes it takes for resource i in shift j to serve 1 patient
    :param o: number of patients overflow from previous shifts for resource i in shift j

    :return: number of patients still waiting 
    """
    cur_waiting = oij
    staff_availability = {staff_idx: 0 for staff_idx in range(xij)}   # dict to hold minutes until free for each staff member

    # Increment the simulation 1 minute at a time
    for minute in range(j*T, (j+1)*T):

        # Record patient arrival
        if minute in arrival_times[i]:
            cur_waiting += 1

        x_available = [k for k, v in staff_availability.items() if v == 0] # keys of staff that are free
        if not x_available or minute + tij > (j+1)*T:  # if no available staff or not enough time remaining in shift
            pass 
        elif not cur_waiting:                           # if there are no patients waiting
            pass
        elif cur_waiting <= len(x_available):          # if enough staff to attend to number of patients waiting
            for k in range(cur_waiting):
                staff_availability[x_available[k]] = tij
                served_times[i].append(minute)
            cur_waiting = 0
        else:                                          # if less staff available than waiting patients
            for k in x_available:
                staff_availability[k] = tij
                served_times[i].append(minute)
            cur_waiting -= len(x_available)
            
        # decrement the time until each staff is free by 1 minute
        for k in staff_availability.keys():
            staff_availability[k] = max(0, staff_availability[k]-1)

    return cur_waiting


def simulation(x=x, t=t, N=N, arrival_times=ARRIVAL_TIMES):
    """Runs simulation per shift for each resource
    :param x: matrix of resources available
    """
    served_times = [[] for _ in range(N)]

    # N: resource categories
    for i in range(N):
        o_1 = simulation_by_shift(served_times=served_times, i=i, j=0, xij=x[i][0], tij=t[i][0], oij=0, arrival_times=arrival_times) # shift 1 
        o_2 = simulation_by_shift(served_times=served_times, i=i, j=1, xij=x[i][1], tij=t[i][1], oij=o_1, arrival_times=arrival_times) # shift 2
        o_3 = simulation_by_shift(served_times=served_times, i=i, j=2, xij=x[i][2], tij=t[i][2], oij=o_2, arrival_times=arrival_times) # shift 3

        if o_3 != 0:
            return np.inf
        
    wait_times = [np.array(served_times[i]) - np.array(arrival_times[i]) for i in range(N)]
    
    return np.sum([np.sum(wait_times[i]) for i in range(N)])


def calculate_objective(x=x, t=t, c=c, d=d, M=M, N=N):
    """ 
    :param x: matrix of number of staff working for each resource in each shift

    :return: (value of cost function, list of contraints broken if applicable)
    """

    # calculate resource and wait costs
    resource_cost = sum([c[i][j]*x[i][j] for j in range(M) for i in range(N)])
    wait_time = simulation(x, t)
    total_cost = resource_cost + d*wait_time

    # Not all patients were served by the end of the day
    if np.isinf(wait_time):
        return total_cost, True, False
    
    # Wait time is greater than 8 hours
    elif wait_time > 480:
        return total_cost, False, True

    return total_cost, False, False