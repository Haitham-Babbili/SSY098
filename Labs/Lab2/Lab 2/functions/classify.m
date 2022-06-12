function predicted_labels = classify(examples_val,w,w0)
predicted_labels = nan(length(examples_val),1);
for i=1:length(examples_val)
    if sum(dot(examples_val{i},w)) > w0
        predicted_labels(i) = 1;
    else
        predicted_labels(i) = 0;
    end
end
end