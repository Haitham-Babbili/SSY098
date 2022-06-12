function [w, w0] = process_epoch(w, w0, lrate, examples, labels)

[wgrad, w0grad] = partial_gradient(w,w0,examples,labels);

%Below we do the simplest form of gradient descent. we update w and w0 by
%taking a small step(lrate) in the gradient direction.
w=w-lrate*wgrad;
w0=w0-lrate*w0grad;