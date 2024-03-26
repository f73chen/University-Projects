#!/usr/bin/env python3
"""
ECE406: Assignment 5, Q4
You will need to install scipy ('pip3 install scipy') for the import command to work.  Do not use any other external libraries
"""
from scipy.optimize import linprog

################################################################################
# SUBMISSION INSTRUCTIONS FOR A5Q4
#   1. Write your username and student number in the box below
#   2. Submit your code as ece406w24-A5-<WatIAMusername>.py to the LEARN Dropbox
#      where <WatIAMusername> is replaced by your WatIAM username
#   3. Submit the signed Academic Integrity form to the LEARN Dropbox
#   4. Submit a screencap of your max_flow function 
#      and the comment box containing your username and student
#      number to Crowdmark.
################################################################################

################################################################################
# student info
#
# WatIAM username: f73chen
# Student number: 20823934
################################################################################


def max_flow(cap, s, t):
    """
    Input: A matrix giving the capacity on each edge.
           If cap[i,j] = 0, then the edge (i,j) is not in the graph
           A source s and sink node t,
    Output: A matrix giving the flow on each edge,
            A number giving the value of the max flow.
    """
    n = len(cap)

    # TODO: implement the proper objective function and constraints, then call linprog to solve the LP
    # 1. Define the upper and lower variable bounds
    bounds = []
    for i in range(n):
        bounds += [(0, cap[i][j]) for j in range(n)]
        
    # 2. Define equality constraints
    # For all nodes except s and t, total flow entering - total flow exiting = 0
    # e.g.
    #   0, -1, 0, 0, 0, 
    #   1,  0, 1, 1, 1, 
    #   0, -1, 0, 0, 0, 
    #   0, -1, 0, 0, 0, 
    #   0, -1, 0, 0, 0
    Aeq = []
    beq = []
    for i in range(n):
        if i != s and i != t:
            flow_i = [0] * n**2

            for j in range(n):
                if j != i:
                    idx = n*i + j
                    flow_i[idx] = 1

            for k in range(n):
                if k != i:
                    idx = i + n*k
                    flow_i[idx] = -1

            Aeq += [flow_i]
            beq += [0]
    
    # 3. Define objective function as maximizing the total flow going out of node s (source)
    c = [0] * n**2                  # Set all coefficients to 0
    for i in range(n*s, n*(s+1)):   # Set edges outgoing from node s to -1 (convert maximization to minimization)
        c[i] = -1

    # 4. Get the results from the optimizer
    opt = linprog(c=c, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
    x = opt["x"]
    flows_per_edge = None # Should be a (length-n) list of (length-n) lists. The i-th entry in the outer
                          # list should be a list of all outgoing flows from the i-th vertex to all other vertices.
    total_flow = -opt["fun"] # Should be a float indicating the total flow for the system.

    # 5. Format the result without using Numpy
    flows_per_edge = [[x[i*n+j] for j in range(n)] for i in range(n)]

    return flows_per_edge, total_flow


def example():
    """
    The following is an example to get you started
    """
    # nine variables, each has an upper and lower bound
    bounds = [(0, 0), (0, 3), (0, 1),
              (0, 0), (0, 0), (0, 1),
              (0, 0), (0, 0), (0, 0)]

    # an equality constraint
    Aeq = [[0, -1, 0, 1, 1, 1, 0, -1, 0]]
    beq = [0]

    # the objective c function
    c = [-1, -1, -1, 0, 0, 0, 0, 0, 0]

    # solving
    opt = linprog(c=c, A_eq=Aeq, b_eq=beq, bounds=bounds, method='revised simplex')
    print("\n example output: \n", opt)


def main():
    """
    Testing your LP.  The following is a single example.  Your alg
    should work for any input.
    """
    # example()
    # the output of the example is the following :
     #     con: array([0.])
     #     fun: -2.0
     # message: 'Optimization terminated successfully.'
     #     nit: 2
     #   slack: array([], dtype=float64)
     #  status: 0
     # success: True
     #       x: array([0., 1., 1., 0., 0., 1., 0., 0., 0.])

    # Note:
    # 1) the optimization has a value of opt.val = -2.0.
    #    linprog solves minimization problems.
    #    To solve a maximization we solve:  min -c^T x.
    #
    # 2)  the array opt.x contains the value of each variable.
    #     For example, the value of variable 1 (0 indexing) has value 1.0,
    #     which lies between its lower and upper bounds of 0 and 3.

    # TEST PROBLEM -- the optimal solution for this should be 7
    c = [[0, 3, 4, 0, 0],
         [0, 0, 1, 0, 2],
         [0, 0, 0, 5, 0],
         [0, 0, 0, 0, 6],
         [1, 1, 0, 0, 0]]
    s = 0
    t = 4

    print()
    print('Running LP for test problem')
    print(max_flow(c, s, t))
    ##############
    ## Hint:
    # To call linprog, you need variables with a single index.  That is,
    # you can't directly define the variables flow[i,j].  So, you'll have
    # to concatenate the columns/rows into a single array x of length n^2.
    # A common way is to store flow[i,j] in position i * n + j of the array x.

    # Notice, that when thought of like this, example() encodes a max flow problem for a graph with three vertices and nine edges.
    # Just three of the edges have non-zero capacity: (0,1), (0,2) and (1,2),
    # with capacities of 3, 1, and 1, respectively. s = 0 and t = 2.
    ####################


if __name__ == '__main__':
    main()
