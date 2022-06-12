function [w, w0] = process_epoch2(w, w0, lrate, examples_train, labels_train)
%
% Lrate is our learning rate, we assume a value within 0.01 and 0.0001
trial_examples_train = examples_train(1:100);
trial_labels_train = labels_train(1:100);

%Create a row vector containing a random permutation of the integers 
%from the set without repeating elements.
% rpm = randperm(length(trial_examples_train)); %
% use this for all questiones except 2.7
 rpm=linspace(1,length(trial_examples_train)); % use this for question 2.7
for i = 1:length(trial_examples_train)
    examples_train(i) = trial_examples_train(rpm(i));
    labels_train(i) = trial_labels_train(rpm(i));

    [wgrad, w0grad]= partial_gradient(w, w0, examples_train(i),labels_train(i));
    
    w = w - (lrate*wgrad);
    w0 = w0 - (lrate*w0grad);
    
    
    
end 
end