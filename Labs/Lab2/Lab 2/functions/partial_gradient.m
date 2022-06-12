function [wgrad, w0grad] = partial_gradient(w, w0, example_train, label_train)
    y = sum(dot(example_train,w)) + w0; % y = I "dot" w + w
    w0grad = exp(y)/(exp(y)+1) - label_train; % label - sigmoid.
    wgrad = example_train.*w0grad;
end

