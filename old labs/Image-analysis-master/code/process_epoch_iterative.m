function [w, w0]=process_epoch_iterative(w,w0,lrate,examples_train, labels_train)
N=size(labels_train,1); % amount of steps in an epoch
for i=1:N

[wgrad,w0grad]=partial_gradient(w,w0,examples_train{i},labels_train(i));

% update weigths and bias
w=w-lrate.*wgrad;
w0=w0-lrate.*w0grad;

end
end