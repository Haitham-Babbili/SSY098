function [wgrad, w0grad] = partial_gradient( w, w0, example_train, label_train )
% Thsi function is to calculate the gradient of loss function with respect
% to w and w0 from one example_train image and its label_train.
%   Inputs:
%   - w : This should be like a 35x35x3 matrix as input weight
%   - w0 : a number as a input weight
%   - example_train : an image of data set
%   - label_train : the real label for example
%   Output:
%   - wgrad : the partial gradient of loss function as to w
%   - w0grad : the partial gradient of loss function as to w0

%   In each iteration of stochastic gradient descent,the loss function
%   can be as follows:
%   L = -[label_train*ln(p) + (1-label_train)*ln(1-p)] (+ lambda*w(w0)),
%   p = exp(y)/(1+exp(y)) = 1/(1/exp(y))+1 = 1/(exp(-y)+1) 
%   y = I*w + w0, where I is the input example,
%   dL/dw = dL/dp * dp/dy * dy/dw
%         = (p - label_train) * I
%   dL/dw0 = p - label_train
% 
% Calculate y = I*w + w0

et = cell2mat(example_train);
% et = cell2mat(example_train); converts a cell array into an ordinary array. 
%The elements of the cell array must all contain the same data type, 
%and the resulting array is of that data type.
Iw = sum(dot(et, w));
y = Iw + w0;

% Calculation of probability using sigmoid function
p = exp(y) / (1+exp(y));

% Calculate the partial gradient of w and w0
% w0grad is a scalar output
w0grad = (p - label_train); %for * w0,wgrad same size as w;
wgrad = et * (p - label_train); % wgrad same size as w


% if y is big all positive images will give wgrad=0 and all negative will  
% give wgrad = example_train

end

