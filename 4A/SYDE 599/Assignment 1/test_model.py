import torch
import torch.nn as nn
import torch.nn.functional as F
import matplotlib.pyplot as plt
import pickle

EPOCHS = 5
LEARNING_RATE = 0.01

# Define the network
class NeuralNet(nn.Module):
    def __init__(self):
        super(NeuralNet, self).__init__()
        self.hidden1 = nn.Linear(2, 10)     # 1st hidden layer with 10 neurons
        self.hidden2 = nn.Linear(10, 10)    # 2nd hidden layer with 10 neurons
        self.output = nn.Linear(10, 1)      # Output layer

    def forward(self, x):
        x = F.relu(self.hidden1(x))
        x = F.relu(self.hidden2(x))
        x = self.output(x)
        return x
    
# Load a model with weights and biases from a pickle file
def load_weights(model, filename="assignment-one-test-parameters.pkl"):
    # Read the pickle file
    with open(filename, "rb") as f:
        data = pickle.load(f)

        inputs = torch.tensor(data["inputs"], dtype=torch.float32)
        targets = torch.tensor(data["targets"], dtype=torch.float32)

        w1 = torch.tensor(data["w1"], dtype=torch.float32)
        w2 = torch.tensor(data["w2"], dtype=torch.float32)
        w3 = torch.tensor(data["w3"], dtype=torch.float32)

        b1 = torch.tensor(data["b1"], dtype=torch.float32)
        b2 = torch.tensor(data["b2"], dtype=torch.float32)
        b3 = torch.tensor(data["b3"], dtype=torch.float32)

    # Set the model weights and biases
    with torch.no_grad():
        model.hidden1.weight.data = w1
        model.hidden1.bias.data = b1

        model.hidden2.weight.data = w2
        model.hidden2.bias.data = b2

        model.output.weight.data = w3
        model.output.bias.data = b3

    return model, inputs, targets

# Define the loss function
def loss_fn(y_hat, y):
    return torch.mean((y_hat - y)**2) / 2

# Print the gradients for the test model
def first_layer_gradients(model, inputs, targets):
    x = inputs[0]
    y = targets[0]

    model.zero_grad()           # Clear the gradients
    y_hat = model(x).squeeze()  # Turn the output into a scalar
    loss = loss_fn(y_hat, y)    # Calculate the loss
    loss.backward()             # Calculate the gradients

    return model.hidden1.weight.grad, model.hidden1.bias.grad

# Train the model and plot losses
def plot_training_curve(model, inputs, targets):
    optimizer = torch.optim.SGD(model.parameters(), lr=LEARNING_RATE)
    losses = []

    # Compute average loss before training
    with torch.no_grad():
        initial_loss = loss_fn(model(inputs).squeeze(), targets)
        losses.append(initial_loss)

    print(f"Epoch 0: average loss = {initial_loss.item():.3f}")

    # Train for 5 epochs and record the loss after each epoch
    for epoch in range(EPOCHS):
        y_hat = model(inputs).squeeze()
        loss = loss_fn(y_hat, targets)

        optimizer.zero_grad()   # Zero the gradients
        loss.backward()         # Backprop
        optimizer.step()        # Update parameters

        # Compute average loss after each epoch
        with torch.no_grad():
            epoch_loss = loss_fn(model(inputs).squeeze(), targets)
            losses.append(epoch_loss)

        print(f"Epoch {epoch + 1}: average loss = {epoch_loss.item():.3f}")

    # Plot the training curve
    plt.plot(range(EPOCHS + 1), losses)
    plt.xlabel('Epoch')
    plt.ylabel('Average Loss')
    plt.title('Training Curve')
    plt.show()

if __name__ == "__main__":
    # Set up the model
    model = NeuralNet()
    model, inputs, targets = load_weights(model)

    # Print the first-layer gradients of the untrained model
    weight_grad, bias_grad = first_layer_gradients(model, inputs, targets)
    print(f"Weight gradients: \n{model.hidden1.weight.grad}")
    print(f"Bias gradients: \n{model.hidden1.bias.grad}")

    # Train the model
    plot_training_curve(model, inputs, targets)


