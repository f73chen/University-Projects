import numpy as np
import constants as const
import objective_function as obj

# optimal x
x = np.array([[1, 2, 1],
              [1, 1, 1],
              [3, 3, 2],
              [1, 1, 1],
              [1, 1, 1],
              [1, 1, 1],
              [1, 1, 1],
              [1, 1, 1],
              [1, 1, 1]])

# inputs
T = const.T  # number of minutes in a shift
N = const.N  # number of resource categories
M = const.M  # number of shifts
# x = const.x  # staff availability matrix
t = const.t  # time for resource matrix
p = const.p  # patient arrival matrix
c = const.c  # cost of resource matrix
d = const.d  # cost of waiting 1 minute

ARRIVAL_TIMES = obj.calculate_arrival_times(N=N, M=M, T=T, p=p)

# analysis
obj_cost = obj.calculate_objective(x=x, t=t, c=c, p=p, d=d, N=N, M=M, T=T, arrival_times=ARRIVAL_TIMES)
resource_cost = sum([c[i][j]*x[i][j] for j in range(M) for i in range(N)])
wait_time = obj.simulation(x=x, t=t, N=N, arrival_times=ARRIVAL_TIMES)

print(obj_cost)
print(resource_cost)
print(wait_time)

