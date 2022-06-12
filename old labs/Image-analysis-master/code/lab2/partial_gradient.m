function [wgrad, w0grad]= partial_gradient(w,w0,example_train,label_train)
    K=dot(example_train,w);
    y=sum(K(:))+w0;
    p=1/(exp(-y)+1); % alternative way of writing p 
% so the following gradients are calculated by doing the partial
% derivatives of L_i.
   w0grad=(p-label_train);
   wgrad=example_train.*w0grad;
end