function [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train)
    for i=1:length(examples_train)
       [wgrad, w0grad] = partial_gradient(w, w0, examples_train{i}, labels_train(i));
       w = w - lrate*wgrad;
       w0 = w0 - lrate*w0grad;
    end
end