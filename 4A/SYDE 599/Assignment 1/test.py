import numpy as np
import autodiff

# Test if the unpickled weights and biases have the expected shapes
def test_unpickle_shapes():
    weights, biases, inputs, targets = autodiff.unpickle_weights(filename="assignment-one-test-parameters.pkl")
    
    # Weights between layers
    assert len(weights) == 3
    assert weights[0].shape == (2, 10)
    assert weights[1].shape == (10, 10)
    assert weights[2].shape == (10, 1)

    # Biases for each layer
    assert len(biases) == 3
    assert len(biases[0]) == 10
    assert len(biases[1]) == 10
    assert len(biases[2]) == 1

    # Inputs and targets
    assert len(inputs[0]) == 2
    assert len(inputs) == len(targets)

# Test if nodes in the network are connected correctly
# Number of nodes per layer, node functions, node connections, loading weights and biases
def test_network_connections(print_details=False):
    # Instantiate the network
    weights = [[[1, 2, 3], [4, 5, 6]], [[7], [8], [9]]]
    biases = [[1, 2, 3], [4]]
    model = autodiff.Network(layers=[2, 3, 1], has_relu=[True, False], w=weights, b=biases)

    if print_details:
        for node in model.flattened_nodes:
            detail = ""
            if node.function == "multiply_weights":
                detail += f"--> weight: {node.weight}"
            if node.function == "add_bias":
                detail += f"--> bias: {node.bias}"
            print(node.function, len(node.pre_nodes), len(node.post_nodes), [n.function for n in node.pre_nodes], [n.function for n in node.post_nodes], detail)

    # Number of nodes per layer
    assert len(model.flattened_nodes) == 21 # 6 weights + 3 sums + 3 biases + 3 relus + 3 weights + 1 sum + 1 bias + 1 output
    assert len(model.nodes) == 3            # 2 layers + out
    
    assert len(model.nodes[0]) == 4         # Layer 1: weights, sums, biases, relus
    assert len(model.nodes[0][0]) == 2      # Layer 1 weights: 2 branches
    assert len(model.nodes[0][0][0]) == 3   # Layer 1 branch 1: 3 nodes
    assert len(model.nodes[0][1]) == 3      # Layer 1 sums: 3 nodes
    assert len(model.nodes[0][2]) == 3      # Layer 1 biases: 3 nodes
    assert len(model.nodes[0][3]) == 3      # Layer 1 relus: 3 nodes

    assert len(model.nodes[1]) == 3         # Layer 2: weights, sums, biases
    assert len(model.nodes[1][0]) == 3      # Layer 2 weights: 3 branches
    assert len(model.nodes[1][0][0]) == 1   # Layer 2 branch 1: 1 node
    assert len(model.nodes[1][1]) == 1      # Layer 2 sums: 1 node
    assert len(model.nodes[1][2]) == 1      # Layer 2 biases: 1 node

    # Node functions
    assert model.nodes[0][0][0][0].function == "multiply_weights"
    assert model.nodes[0][1][0].function ==    "sum_weights"
    assert model.nodes[0][2][0].function ==    "add_bias"
    assert model.nodes[0][3][0].function ==    "relu"
    assert model.nodes[1][0][0][0].function == "multiply_weights"
    assert model.nodes[1][1][0].function ==    "sum_weights"
    assert model.nodes[1][2][0].function ==    "add_bias"
    assert model.nodes[2].function ==          "subtract_target"

    # Node connections
    assert model.nodes[0][0][0][0].post_nodes == [model.nodes[0][1][0]]     # weight --> sum
    assert model.nodes[0][1][0].post_nodes ==    [model.nodes[0][2][0]]     # sum --> bias
    assert model.nodes[0][2][0].post_nodes ==    [model.nodes[0][3][0]]     # bias --> relu
    assert model.nodes[0][3][0].post_nodes ==    [model.nodes[1][0][0][0]]  # relu --> weight
    assert model.nodes[1][0][0][0].post_nodes == [model.nodes[1][1][0]]     # weight --> sum
    assert model.nodes[1][1][0].post_nodes ==    [model.nodes[1][2][0]]     # sum --> bias
    assert model.nodes[1][2][0].post_nodes ==    [model.nodes[2]]           # bias --> output
    assert model.nodes[2].post_nodes ==          []

    assert model.nodes[0][0][0][0].pre_nodes == []
    assert model.nodes[0][1][0].pre_nodes ==    [model.nodes[0][0][0][0], model.nodes[0][0][1][0]]  # weight <-- sum
    assert model.nodes[0][2][0].pre_nodes ==    [model.nodes[0][1][0]]      # sum <-- bias
    assert model.nodes[0][3][0].pre_nodes ==    [model.nodes[0][2][0]]      # bias <-- relu
    assert model.nodes[1][0][0][0].pre_nodes == [model.nodes[0][3][0]]      # relu <-- weight
    assert model.nodes[1][1][0].pre_nodes ==    [model.nodes[1][0][0][0], model.nodes[1][0][1][0], model.nodes[1][0][2][0]] # weight <-- sum
    assert model.nodes[1][2][0].pre_nodes ==    [model.nodes[1][1][0]]      # sum <-- bias
    assert model.nodes[2].pre_nodes ==          [model.nodes[1][2][0]]      # bias <-- output

    # Weights and biases
    assert model.nodes[0][0][0][0].weight == 1  # Layer 1 branch 1 node 1
    assert model.nodes[0][0][1][0].weight == 4  # Layer 1 branch 2 node 1
    assert model.nodes[1][0][1][0].weight == 8  # Layer 2 branch 2 node 1
    assert model.nodes[0][2][1].bias == 2       # Layer 1 bias node 2
    assert model.nodes[1][2][0].bias == 4       # Layer 2 bias node 1

# Initial losses from both input-output pairs
def test_network_forward():
    # Instantiate the network from class
    weights = [[[1]], [[0.8, -0.6]], [[0.5], [0.5]]]
    biases = [[0], [-0.5, -0.5], [0]]
    model = autodiff.Network(layers=[1, 1, 2, 1], has_relu=[False, True, False], w=weights, b=biases)

    inputs = [[-1], [1]]    # 2 samples with 1 feature each
    targets = [0.5, 0.5]    # 2 targets

    all_losses, _, _ = model.train(inputs=inputs, targets=targets, epochs=1)
    
    # Compare with hand calculated losses
    assert all_losses[0] == np.mean([0.10125, 0.06125])

# First-layer gradients for a single input-output pair
def test_network_backward_single_input():
    # Instantiate the network from class
    weights = [[[1]], [[0.8, -0.6]], [[0.5], [0.5]]]
    biases = [[0], [-0.5, -0.5], [0]]
    model = autodiff.Network(layers=[1, 1, 2, 1], has_relu=[False, True, False], w=weights, b=biases)

    inputs = [[-1]]    # 1 sample
    targets = [0.5]    # 1 target

    _, first_weight_gradient, first_bias_gradient = model.train(inputs=inputs, targets=targets, epochs=1)

    # Compare with hand calculated first layer gradients after epoch with updated weights
    assert first_weight_gradient[0][0] == -0.135
    assert first_bias_gradient[0] == 0.135

# Make sure the accumulated gradients are reset after each epoch
def test_accumulated_gradient_reset():
    # Instantiate the network from class
    weights = [[[1]], [[0.8, -0.6]], [[0.5], [0.5]]]
    biases = [[0], [-0.5, -0.5], [0]]
    model = autodiff.Network(layers=[1, 1, 2, 1], has_relu=[False, True, False], w=weights, b=biases)

    inputs = [[-1], [1]]    # 2 samples with 1 feature each
    targets = [0.5, 0.5]    # 2 targets

    model.train(inputs=inputs, targets=targets, epochs=1)
    for node in model.flattened_nodes:
        assert node.accumulated_gradient == 0

test_unpickle_shapes()
test_network_connections()
test_network_forward()
test_network_backward_single_input()
test_accumulated_gradient_reset()