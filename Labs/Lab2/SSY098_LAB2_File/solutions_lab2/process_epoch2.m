function [w, w0] = process_epoch2(w, w0, lrate, examples_train, labels_train)
%
% Lrate is our learning rate, we assume a value within 0.01 and 0.0001
trial_examples_train = examples_train(1:100);
trial_labels_train = labels_train(1:100);


 linear_perm=linspace(1,length(trial_examples_train)); 
for i = 1:length(trial_examples_train)
    examples_train(i) = trial_examples_train(linear_perm(i));
    labels_train(i) = trial_labels_train(linear_perm(i));

    [wgrad, w0grad]= partial_gradient(w, w0, examples_train(i),labels_train(i));
    
    w = w - (lrate*wgrad);
    w0 = w0 - (lrate*w0grad);
    
    
    
end 
end