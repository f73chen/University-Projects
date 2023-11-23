import nengo
from nengo.utils.matplotlib import rasterplot

import numpy as np
import matplotlib.pyplot as plt

model = nengo.Network()

with model:
    """"""
    ensemble = nengo.Ensemble(50, 1, seed=5)    # num_neurons, dimensions?, random seed
    stimulus = nengo.Node(0)
    nengo.Connection(stimulus, ensemble)
    # Right click to get slider for stimulus
    # Pause and slide timeline to view historical activations

    """"""
    ensemble.encoders = [[1], [-1]]
    ensemble.max_rates = [100, 100]
    ensemble.intercepts = [-0.5, -0.5]  # Want neurons to overlap especially at x=0

    """"""
    a = nengo.Ensemble(50, 1)
    stim = nengo.Node(0)
    nengo.Connection(stim, a)

    b = nengo.Ensemble(51, 1)

    def my_func(x):
        if x > 0:
            return 1
        else:
            return x * x

    nengo.Connection(a, b, synapse=0.05, function=my_func)
    # Computes the identity function unless a function is specified

    """"""
    a = nengo.Ensemble(50, 1)
    b = nengo.Ensemble(50, 1)
    c = nengo.Ensemble(50, 2)
    stim1 = nengo.Node(0)
    stim2 = nengo.Node(0)

    nengo.Connection(stim1, a)
    nengo.Connection(stim2, b)

    nengo.Connection(a, c[0])
    nengo.Connection(b, c[1])

    """"""
    net = nengo.Network()
    with net:
        two_d_probe = nengo.Probe(two_d_ensemble, synapse=0.01)
        product_probe = nengo.Probe(product_ensemble, synapse=0.01)
    sim = nengo.Simulator(net)
    sim.run(5.0)
    print(sim.data[product_probe][-10:])