function [wgrad, w0grad] = partial_gradient(w, w0, example, label)

scal = dot(example,w);
y = sum(scal(:))+w0; %calculates y = I*w +w0, we get a scalar
%p = exp(y)/(1+exp(y)) = 1/(1/exp(y))+1 = 1/(exp(-y)+1) 
%calculates probability with sigmoid 
p = 1/(exp(-y)+1);

% Calculate the partial gradient of w and w0, w0grad*Image = wgrad
%L_i = -ln(p), p = 1/(e^-y + 1), y = dot(I,w) + w0
%dy/dw = I where I is an image
% from chain rule we get dL_i/dw =(p-1)*I for positive imagaes and
%dL_i/dw=p*I for negative images
%dL_i/dw0=(p-1) --> (dL_i/dw0)*I = dL_i/dw
w0grad = (p - label);
wgrad = example .* w0grad;

%if y big all positive images will give wgrad=0 and all negativ will give 
%wgrad=example  