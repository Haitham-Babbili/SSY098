function [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train)

tmp_examples_train = examples_train;
tmp_labels_train = labels_train;

% r = randperm(length(tmp_examples_train)); % use this for all questiones except 2.7
r=linspace(1,length(tmp_examples_train)); % use this for question 2.7
for i = 1:length(examples_train)
    examples_train(i) = tmp_examples_train(r(i));
    examples_labels(i) = tmp_labels_train(r(i));

    [wgrad, w0grad]= partial_gradient(w, w0, examples_train(i),examples_labels(i));
    
    w = w - (lrate*wgrad);
    w0 = w0 - (lrate*w0grad);
    
    
    
end 
end
    
    
    