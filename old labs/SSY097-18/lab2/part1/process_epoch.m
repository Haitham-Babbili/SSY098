function [w, w0] = process_epoch(w, w0, lrate, examples, labels)


idx = randperm(length(examples));       % Reordering data in random manner. 
exRand = examples(idx);                 % Same reordering for examples and labels. 
labelRand = labels(idx); 

% Go through examples, compute partial gradients, update w and w0
% accordingly. 
for i=1:length(examples)
     [wgrad, w0grad] = partial_gradient(w, w0, exRand{i}, labelRand(i)); 
     w = w - lrate * wgrad;
     w0 = w0 - lrate * w0grad; 
end


end

