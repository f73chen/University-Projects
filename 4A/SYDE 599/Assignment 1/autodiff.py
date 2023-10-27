import numpy as np
import pickle
import matplotlib.pyplot as plt

EPOCHS = 5
LEARNING_RATE = 0.01

class Node():
    # Initialization
    def __init__(self, pre_nodes, function, weight=None, bias=None, value=None):
        # Initialize the attributes
        self.pre_nodes = pre_nodes
        self.post_nodes = []
        self.value = value
        self.weight = weight
        self.bias = bias
        self.function = function

        # Connect the nodes
        for node in pre_nodes:
            node.post_nodes.append(self)

        # Additional attributes
        self.input = 0      # Local inputs to calculate weight/bias gradients
        self.delta = 0      # Local delta for gradient propagation
        self.gradient = 0   # Local gradient
        self.accumulated_gradient = 0   # Local gradient for updates and printing

    # Forward pass: Calculate values and trigger the next nodes
    def forward(self, x=None, y=None):
        # Use feature x if node in first layer, else use pre-node values to calculate current value
        if x:
            self.input = x
        else:
            self.input = np.sum([node.value for node in self.pre_nodes])

        # Multiply input (scalar) with weight (scalar)
        if self.function == "multiply_weights":
            self.value = self.input * self.weight

        # Add pre-node weighted inputs
        # Note: This is the only operation that takes multiple inputs
        if self.function == "sum_weights":
            self.value = self.input

        # Add bias to weighted sum
        if self.function == "add_bias":
            self.value = self.input + self.bias

        # Apply ReLU to weighted sum + bias
        if self.function == "relu":
            self.value = max(0, self.input)

        # y_hat - y
        if self.function == "subtract_target":
            self.value = self.input - y

    # Backward pass: Calculate gradients and update weights/biases
    def backward(self):
        # Weight gradient = delta * input
        if self.function == "multiply_weights":
            self.delta = self.post_nodes[0].delta * self.weight
            self.gradient = self.post_nodes[0].delta * self.input
            self.accumulated_gradient += self.gradient

        # Sum weights can only connect to 1 post-node (add_bias)
        if self.function == "sum_weights":
            self.delta = self.post_nodes[0].delta

        # Bias gradient = delta * 1
        # Bias node could have multiple post-nodes
        if self.function == "add_bias":
            self.delta = np.sum([node.delta for node in self.post_nodes])
            self.gradient = self.delta
            self.accumulated_gradient += self.gradient

        # ReLU node could have multiple post-nodes
        if self.function == "relu":
            if self.input > 0:
                self.delta = np.sum([node.delta for node in self.post_nodes])
            else:
                self.delta = 0

        # delta = value = y_hat - y
        if self.function == "subtract_target":
            self.delta = self.value

class Network():
    # Build the connections between layers of nodes
    def __init__(self, layers, has_relu, w, b):
        # Initialize the attributes
        self.layers = layers    # [# of features, size of each hidden layer, # of outputs]
        self.has_relu = has_relu

        # Additional attributes
        self.nodes = []     # [[ [[w11], [w12]       ], [sum1], [b1], [relu1] ],    layer 1
                            #  [ [[w21], [w22], [w23]], [sum2], [b2], [relu2] ],    layer 2
                            #  [ [[w31], [w32], [w33]], [sum3], [b3]          ],    layer 3
                            #  out                                             ]

        # Assume W in shape (i, j) and b in shape (j) where i = # of nodes in current layer and j = # of nodes in next layer
        # For each layer:
        for l in range(len(layers) - 1):
            layer_nodes = []        # [ [[w111, w112, w113], [w121, w122, w123]], [sum11, sum12, sum13], [b11, b12, b13], [relu11, relu12, relu13] ]

            # "Multiply_weights" nodes
            weight_nodes = []       # [[w111, w112, w113], [w121, w122, w123]]
            for i in range(layers[l]):
                branch_nodes = []    # [w111, w112, w113]
                for j in range(layers[l+1]):
                    pre_nodes = [] if l == 0 else [self.nodes[-1][-1][i]]
                    node = Node(pre_nodes=pre_nodes, function="multiply_weights", weight=w[l][i][j])
                    branch_nodes.append(node)
                weight_nodes.append(branch_nodes)
            layer_nodes.append(weight_nodes)

            # "sum_weights" nodes
            sum_nodes = []          # [sum11, sum12, sum13]
            for j in range(layers[l+1]):
                node = Node(pre_nodes=[branch[j] for branch in weight_nodes], function="sum_weights")
                sum_nodes.append(node)
            layer_nodes.append(sum_nodes)
                
            # "add_bias" nodes
            bias_nodes = []         # [b11, b12, b13]
            for j in range(layers[l+1]):
                node = Node(pre_nodes=[sum_nodes[j]], function="add_bias", bias=b[l][j])
                bias_nodes.append(node)
            layer_nodes.append(bias_nodes)

            # "relu" nodes
            if has_relu[l]:
                relu_nodes = []    # [relu11, relu12, relu13]
                for j in range(layers[l+1]):
                    node = Node(pre_nodes=[bias_nodes[j]], function="relu")
                    relu_nodes.append(node)
                layer_nodes.append(relu_nodes)

            self.nodes.append(layer_nodes)
        # "subtract_target" node
        node = Node(pre_nodes=self.nodes[-1][-1], function="subtract_target")
        self.nodes.append(node)

        # Also store a flattened list of all nodes for convenient iteration
        self.flattened_nodes = self.flatten_list(nodes=self.nodes)

    # Helper function: flatten the list of nodes
    def flatten_list(self, nodes):
        flattened_nodes = []
        for layer_nodes in nodes:
            if isinstance(layer_nodes, list):
                flattened_nodes += self.flatten_list(layer_nodes)
            else:
                flattened_nodes.append(layer_nodes)
        return flattened_nodes
    
    # Helper function: update weights & biases from accumulated gradients then reset gradients
    def update_weights(self, batch_size):
        for node in self.flattened_nodes:
            if node.function == "multiply_weights":
                node.weight -= LEARNING_RATE * node.accumulated_gradient / batch_size
                node.accumulated_gradient = 0
            if node.function == "add_bias":
                node.bias -= LEARNING_RATE * node.accumulated_gradient / batch_size
                node.accumulated_gradient = 0

    # Train the model
    # Assume inputs and targets are in shape (n, i) and (n) where n = # of samples, i = # of features (x1, x2...)
    def train(self, inputs, targets, epochs=EPOCHS):
        all_losses = []
        first_weight_gradient = []
        first_bias_gradient = []

        # Run for 1 more epoch so we can print the final loss
        for epoch in range(epochs + 1):
            epoch_losses = []
            # Do 1 forward and 1 backward pass for each sample
            for n, sample in enumerate(inputs): # nth sample = [x1, x2]
                """ Forward Pass """
                # Give inputs to the first layer of weights
                # branch 1 = [w111, w112, w113] gets feature x1, branch 2 = [w121, w122, w123] gets feature x2
                for i, branch in enumerate(self.nodes[0][0]):
                    for node in branch:
                        node.forward(x=sample[i])

                # Forward pass through the rest of the nodes except the last one
                # Skip the first layer weights since they were already called
                num_skipped = self.layers[0] * self.layers[1]   # 2 * 3 = 6
                for node in self.flattened_nodes[num_skipped:-1]:
                    node.forward()

                # Give the target to the last node
                self.flattened_nodes[-1].forward(y=targets[n])

                y_hat_minus_y = self.flattened_nodes[-1].value  # y_hat - y = subtract_target node value
                loss = (y_hat_minus_y)**2 / 2
                epoch_losses.append(loss)

                """ Backward Pass """
                for node in reversed(self.flattened_nodes):
                    node.backward()

                """ Print the first layer weight and bias gradients """
                if n == 0 and epoch == 0:
                    for i, branch in enumerate(self.nodes[0][0]):
                        feature_weights = []
                        for node in branch:
                            feature_weights.append(np.round(node.gradient, 4))
                        first_weight_gradient.append(feature_weights)
                    
                    first_weight_gradient = np.array(first_weight_gradient).T
                    print("First Layer Weight Gradients:\n", first_weight_gradient)

                    for i, node in enumerate(self.nodes[0][2]):
                        first_bias_gradient.append(np.round(node.gradient, 4))
                    print("First Layer Bias Gradients:\n", first_bias_gradient)

            # Calculate the average loss per epoch
            avg_epoch_loss = np.mean(epoch_losses)
            all_losses.append(avg_epoch_loss)
            print(f"Epoch {epoch}: average loss = {avg_epoch_loss:.3f}")

            # Update weights and biases + reset gradients
            self.update_weights(batch_size=len(inputs))

        return all_losses, first_weight_gradient, first_bias_gradient

def unpickle_weights(filename):
    with open(filename, 'rb') as f:
        data = pickle.load(f)

        inputs = data["inputs"]
        targets = data["targets"]

        weights = [data["w1"].T, data["w2"].T, data["w3"].T]
        biases =  [data["b1"], data["b2"], data["b3"]]

    return weights, biases, inputs, targets

# Train the model and plot losses
def get_gradients_and_plot_training_curve(model, inputs, targets):
    all_losses, first_weight_gradient, first_bias_gradient = model.train(inputs, targets)
    plt.plot(range(EPOCHS + 1), all_losses)
    plt.xlabel('Epoch')
    plt.ylabel('Average Loss')
    plt.title('Training Curve')
    plt.show()

if __name__ == "__main__":
    # Set up the model
    weights, biases, inputs, targets = unpickle_weights(filename="assignment-one-test-parameters.pkl")
    model = Network(layers=[2, 10, 10, 1], has_relu=[True, True, False], w=weights, b=biases)

    # Train the model
    get_gradients_and_plot_training_curve(model, inputs, targets)