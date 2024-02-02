from __future__ import print_function

from builtins import range
from builtins import object
import numpy as np
import matplotlib.pyplot as plt
from past.builtins import xrange

class TwoLayerNet(object):
    """
    A two-layer fully-connected neural network. The net has an input dimension of
    N, a hidden layer dimension of H, and performs classification over C classes.
    We train the network with a softmax loss function and L2 regularization on the
    weight matrices. The network uses a ReLU nonlinearity after the first fully
    connected layer.

    In other words, the network has the following architecture:

    input - fully connected layer - ReLU - fully connected layer - softmax

    The outputs of the second fully-connected layer are the scores for each class.
    """

    def __init__(self, input_size, hidden_size, output_size, std=1e-4):
        """
        Initialize the model. Weights are initialized to small random values and
        biases are initialized to zero. Weights and biases are stored in the
        variable self.params, which is a dictionary with the following keys:

        W1: First layer weights; has shape (D, H)
        b1: First layer biases; has shape (H,)
        W2: Second layer weights; has shape (H, C)
        b2: Second layer biases; has shape (C,)

        Inputs:
        - input_size: The dimension D of the input data.
        - hidden_size: The number of neurons H in the hidden layer.
        - output_size: The number of classes C.
        """
        self.params = {}
        self.params['W1'] = std * np.random.randn(input_size, hidden_size)
        self.params['b1'] = np.zeros(hidden_size)
        self.params['W2'] = std * np.random.randn(hidden_size, output_size)
        self.params['b2'] = np.zeros(output_size)

    def loss(self, X, y=None, reg=0.0):
        """
        Compute the loss and gradients for a two layer fully connected neural
        network.

        Inputs:
        - X: Input data of shape (N, D). Each X[i] is a training sample.
        - y: Vector of training labels. y[i] is the label for X[i], and each y[i] is
          an integer in the range 0 <= y[i] < C. This parameter is optional; if it
          is not passed then we only return scores, and if it is passed then we
          instead return the loss and gradients.
        - reg: Regularization strength.

        Returns:
        If y is None, return a matrix scores of shape (N, C) where scores[i, c] is
        the score for class c on input X[i].

        If y is not None, instead return a tuple of:
        - loss: Loss (data loss and regularization loss) for this batch of training
          samples.
        - grads: Dictionary mapping parameter names to gradients of those parameters
          with respect to the loss function; has the same keys as self.params.
        """
        # Unpack variables from the params dictionary
        W1, b1 = self.params['W1'], self.params['b1']
        W2, b2 = self.params['W2'], self.params['b2']
        N, D = X.shape

        # Compute the forward pass
        scores = None
        #############################################################################
        # TODO: Perform the forward pass, computing the class scores for the input. #
        # Store the result in the scores variable, which should be an array of      #
        # shape (N, C).                                                             #
        #############################################################################
        # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        # In the forward pass, propagate inputs using the formula y = w * x + b
        # Where w = weights, x = input, and b = bias
        # Perform the multiplication as a dot product
        layer_1_values = X.dot(W1) + b1
        
        # Apply ReLU activation, which is 0 for negative values and unchanged for positive values
        layer_1_values = np.maximum(0, layer_1_values)
        
        # Since the network only has 2 layers, the output is first layer outputs * second layer weights plus biases
        # Scores represent the raw class scores
        # Also known as logits
        # The shape is (N, C) = (Number of samples, Number of classes)
        scores = layer_1_values.dot(W2) + b2

        # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        # If the targets are not given then jump out, we're done
        if y is None:
            return scores

        # Compute the loss
        loss = None
        #############################################################################
        # TODO: Finish the forward pass, and compute the loss. This should include  #
        # both the data loss and L2 regularization for W1 and W2. Store the result  #
        # in the variable loss, which should be a scalar. Use the Softmax           #
        # classifier loss.                                                          #
        #############################################################################
        # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        # The softmax function is defined as exp(x) / sum(exp(x))
        # First, subtract the maximum value from each score to improve numerical stability
        # The maximum is taken for each sample along all classes (axis 1)
        # This shouldn't change the mathematical result, but helps prevent overflow
        # Applying softmax to the raw scores gives the class probabilities
        # Softmax is used to emphasize the highest scores and suppress the lower ones
        def softmax(x):
            normalized_scores = x - np.max(x, axis=1, keepdims=True)
            exp_scores = np.exp(normalized_scores)
            return exp_scores / np.sum(exp_scores, axis=1, keepdims=True)
        class_probs = softmax(scores)
        
        # Cross-entropy loss is defined as -log(exp(correct_class_score) / sum(exp(scores))) in the context of softmax classification
        # However, the inside portion is already calculated in class_probs
        # So the formula simplifies to -log(class_probs)
        # The index of the correct class y is used to select the correct class score
        # So the data loss is only calculated for the correct class
        # Finally, the loss is averaged over all N samples
        correct_logprobs = -np.log(class_probs[range(N), y])
        data_loss = np.sum(correct_logprobs) / N
        
        # L2 regularization is defined as the sum of the squared weights multiplied by the regularization factor
        # The purpose of regularization is to limit the size of the weights to prevent overfitting
        # The data loss is added to the regularization loss to get the total loss        
        reg_loss = reg * (np.sum(W1 * W1) + np.sum(W2 * W2))
        loss = data_loss + reg_loss

        # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        # Backward pass: compute gradients
        grads = {}
        #############################################################################
        # TODO: Compute the backward pass, computing the derivatives of the weights #
        # and biases. Store the results in the grads dictionary. For example,       #
        # grads['W1'] should store the gradient on W1, and be a matrix of same size #
        #############################################################################
        # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        # First, copy the class probabilities, which are the softmax of the scores
        # Subtract 1 from all correct class probabilities (indicated by index y)
        # This is so the error is low when: 1) the correct class probability is high, and 2) the incorrect class probabilities are low
        # For example, if a value is supposed to be 0, then the loss is smaller when the model predicts 0
        # Alternatively, if a value is supposed to be 1, then the loss is smaller when the model predicts 1 --> 1 - 1 = 0
        # This pushes the model to predict the correct class with high probability and incorrect classes with low probability
        class_probs_error = class_probs
        class_probs_error[range(N), y] -= 1
        
        # The class_probs_error is divided by the number of samples to get the average error
        # Which is the derivative of the loss with respect to the scores dL/dscores
        dscores = class_probs_error / N
        
        # Calculate dW2 using the chain rule dL/dW2 = dL/dscores * dscores/dW2
        # Since dscores/dW2 is the activations from the first layer,
        # Calculate dW2 as the dot product of the activations and dscores
        # Transpose the activations to match the shape of the weights
        dW2 = np.dot(layer_1_values.T, dscores)
        
        # Similarly, the chain rule is db2 = dL/dscores * dscores/db2
        # Where dscores/db2 is 1 (addition), so the gradient is the sum of the gradients across all samples
        # Note that dscores is already divided by N, so the sum is the average gradient
        # Axis 0 means the sum is taken across all samples for each class
        db2 = np.sum(dscores, axis=0)

        # Then, propagate the gradient back to the hidden layer (dhidden)
        # The chain rule is dL/dhidden = dL/dscores * dscores/dhidden
        # Where dscores/dhidden is the weights W2
        # Transpose the weights to match the shape of the scores
        dhidden = np.dot(dscores, W2.T)
        
        # Apply the gradient of the ReLU activation
        # The gradient is 1 * dhidden for positive values, and 0 * dhidden for negative values
        # Similar to the forward pass, set the gradient to 0 if the previous layer activations are negative (layer 1)
        dhidden[layer_1_values <= 0] = 0
        
        # Calculate dW1 using the chain rule dL/dW1 = dL/dhidden * dhidden/dW1
        # Where dhidden/dW1 is input X
        # Transpose the input to match the shape of the weights
        # Do the same for db1 like db2
        dW1 = np.dot(X.T, dhidden)
        db1 = np.sum(dhidden, axis=0)

        # Add the regularization gradient
        # Since the formula of the regularization term is reg * W^2, the gradient is 2 * reg * W
        dW2 += 2 * reg * W2
        dW1 += 2 * reg * W1

        # Store the gradients in grads with the key as the variable name
        grads['W1'] = dW1
        grads['b1'] = db1
        grads['W2'] = dW2
        grads['b2'] = db2

        # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        return loss, grads

    def train(self, X, y, X_val, y_val,
              learning_rate=1e-3, learning_rate_decay=0.95,
              reg=5e-6, num_iters=100,
              batch_size=200, verbose=False):
        """
        Train this neural network using stochastic gradient descent.

        Inputs:
        - X: A numpy array of shape (N, D) giving training data.
        - y: A numpy array f shape (N,) giving training labels; y[i] = c means that
          X[i] has label c, where 0 <= c < C.
        - X_val: A numpy array of shape (N_val, D) giving validation data.
        - y_val: A numpy array of shape (N_val,) giving validation labels.
        - learning_rate: Scalar giving learning rate for optimization.
        - learning_rate_decay: Scalar giving factor used to decay the learning rate
          after each epoch.
        - reg: Scalar giving regularization strength.
        - num_iters: Number of steps to take when optimizing.
        - batch_size: Number of training examples to use per step.
        - verbose: boolean; if true print progress during optimization.
        """
        num_train = X.shape[0]
        iterations_per_epoch = max(num_train / batch_size, 1)

        # Use SGD to optimize the parameters in self.model
        loss_history = []
        train_acc_history = []
        val_acc_history = []

        for it in range(num_iters):
            X_batch = None
            y_batch = None

            #########################################################################
            # TODO: Create a random minibatch of training data and labels, storing  #
            # them in X_batch and y_batch respectively.                             #
            #########################################################################
            # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

            pass

            # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

            # Compute loss and gradients using the current minibatch
            loss, grads = self.loss(X_batch, y=y_batch, reg=reg)
            loss_history.append(loss)

            #########################################################################
            # TODO: Use the gradients in the grads dictionary to update the         #
            # parameters of the network (stored in the dictionary self.params)      #
            # using stochastic gradient descent. You'll need to use the gradients   #
            # stored in the grads dictionary defined above.                         #
            #########################################################################
            # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

            pass

            # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

            if verbose and it % 100 == 0:
                print('iteration %d / %d: loss %f' % (it, num_iters, loss))

            # Every epoch, check train and val accuracy and decay learning rate.
            if it % iterations_per_epoch == 0:
                # Check accuracy
                train_acc = (self.predict(X_batch) == y_batch).mean()
                val_acc = (self.predict(X_val) == y_val).mean()
                train_acc_history.append(train_acc)
                val_acc_history.append(val_acc)

                # Decay learning rate
                learning_rate *= learning_rate_decay

        return {
          'loss_history': loss_history,
          'train_acc_history': train_acc_history,
          'val_acc_history': val_acc_history,
        }

    def predict(self, X):
        """
        Use the trained weights of this two-layer network to predict labels for
        data points. For each data point we predict scores for each of the C
        classes, and assign each data point to the class with the highest score.

        Inputs:
        - X: A numpy array of shape (N, D) giving N D-dimensional data points to
          classify.

        Returns:
        - y_pred: A numpy array of shape (N,) giving predicted labels for each of
          the elements of X. For all i, y_pred[i] = c means that X[i] is predicted
          to have class c, where 0 <= c < C.
        """
        y_pred = None

        ###########################################################################
        # TODO: Implement this function; it should be VERY simple!                #
        ###########################################################################
        # *****START OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        pass

        # *****END OF YOUR CODE (DO NOT DELETE/MODIFY THIS LINE)*****

        return y_pred
