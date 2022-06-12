function [wgrad, w0grad] = partial_gradient(w, w0, example, label)
% Computes partial gradients, for w and w0, for a given example-image.

p = @(y) (1+exp(-y)).^-1;           % Sigmoid function makes sure output is between 0 and 1

y = dot(w(:),example(:)) + w0;      % Input to Sigmoid function. Dot product between weight image and example image.

wgrad = (p(y)-label).*example;      % wgrad same size as w
w0grad = p(y)-label;                % w0grad is a scalar


end

