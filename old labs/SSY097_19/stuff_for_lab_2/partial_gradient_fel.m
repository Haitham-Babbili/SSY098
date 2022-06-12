function [wgrad, w0grad] = partial_gradient(w, w0, example_train, label_train)


example_train=cell2mat(example_train); 
img = dot(w,example_train); 


y= sum(img(:)) + w0; % calculates y to be used in the sigmoid function 

p = 1/(exp(-y)+1); % sigmoid function,calculates the probability 

w0grad = (p - label_train);
wgrad = example_train .* w0grad;


end 