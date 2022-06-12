function [ w, w0 ] = process_epoch( w, w0, examples, labels )
%PROCESS_EPOCH This function carries out the stochastic gradient descent
%through all images in training dataset.
%   Input arguments:
%   - w : an image parameter
%   - w0 : a parameter in number
%   - examples : the dataset contains training images
%   - labels : a vector consists of all real labels of examples
%   Outputs:
%   - w : the parameter which has been updated
%   - w0 : the parameter which has been updated
% Author: Qixun Qu

% Obtain the number of training images
num = length(examples);

% Reordering the training data
order = randperm(num);

% Set the learning rate
mu = 0.001;

% Through all training data in new order
for i = 1 : num

    % Compute the gradient of w and w0 respectively
    [wgrad, w0grad] = ...
        partial_gradient(w, w0, examples{order(i)}, labels(order(i)));

    % Update w and w0
    w = w - mu * wgrad;
    w0 = w0 - mu * w0grad;

end

end

