function predicted_labels = classify(examples_val,w,w0)
%Function file applies the classifier to the example data.

predicted_labels = nan(length(examples_val),1);
for k=1:length(examples_val)
    if sum(dot(examples_val{k},w)) > w0
        predicted_labels(k) = 1;
    else
        predicted_labels(k) = 0;
    end
end
end