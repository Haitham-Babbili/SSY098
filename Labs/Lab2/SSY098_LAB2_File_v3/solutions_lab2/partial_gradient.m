function [wgrad, w0grad] = partial_gradient( w, w0, example_train, label_train )
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
wgrad = et * w0grad; % wgrad same size as w




end

