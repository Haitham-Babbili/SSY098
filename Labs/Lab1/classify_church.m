function [label, name] = classify_church(image, feature_collection)

[ ~ , descriptors] = extractSIFT(image); 
% coordinates


% the input descriptors need to be transposed to have the same amount of
% columns
corr_colm= matchFeatures(descriptors', feature_collection.descriptors', 'MatchThreshold', 100, 'MaxRatio', 0.7);

tabl_input = tabulate(feature_collection.labels(corr_colm(:,2)));
% row = the row with maximun occuring tabl_input (input image table)
[~, row] = max(tabl_input(:,2));


label = tabl_input(row);
name = feature_collection.names(label);

end

