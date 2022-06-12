function [wgrad, w0grad] = partial_gradient( w, w0, example, label )
%PARTIAL_GRADIENT Compute the gradient of loss function with respect to w
%and w0 from one example image and its label.
%   Input arguments:
%   - w : a 35x35x3 matrix as a weight
%   - w0 : a number as a weight
%   - example : an image of data set
%   - label : the real label for example
%   Output:
%   - wgrad : the partial gradient of loss function as to w
%   - w0grad : the partial gradient of loss function as to w0
%------------------------------------------------------------------------
%   In each iteration of stochastic gradient descent,
%   the loss function is as follows:
%   L = -[b*ln(p) + (1-b)*ln(1-p)], where b is the label of example,
%   p = 1 / (1 + e^(-y)), y = I*w + w0, where I is the input example,
%   dL/dw = dL/dp * dp/dy * dy/dw
%         = -[-(1-b)/(1-p) + b/p] * p(1-p) * I
%         = [(1-b)/(1-p) - b/p] * p(1-p) * I
%         = [p*(1-b) - b*(1-p)] * I
%         = (p - b) * I
%   dL/dw0 = p - b
% Author: Qixun Qu

% Calculate y = I*w + w0
y = example .* w;
y = sum(y(:)) + w0;

% Calculate probability
p = sigmoid(y);

% Set the conefficient of regularization part,
% which may avoid overfitting
lambda = 0.001;

% Calculate the partial gradient of w and w0
w0grad = p - label + lambda * w0;
wgrad = example * (p - label) + lambda * w;

end

