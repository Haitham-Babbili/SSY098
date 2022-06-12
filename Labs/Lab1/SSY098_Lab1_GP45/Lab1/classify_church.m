function [label, name] = classify_church(image, feature_collection)
% - INPUT
% image, feature_collecition (from "church_data.mat")
% - An image has a church in it and needs to be classified
% - feature_collection is a training set that has many descriptors

% - OUTPUT
% label (index and church), name (name of city where the church is lcoated)

[ ~ , descriptors] = extractSIFT(image); 
% coordinates


% The input descriptors need to be transposed to have the same amount of
% columns
corr_colm= matchFeatures(descriptors', feature_collection.descriptors', 'MatchThreshold', 100, 'MaxRatio', 0.7);

tabl_input = tabulate(feature_collection.labels(corr_colm(:,2)));
% row = the row with maximun occuring tabl_input (input image table)
[~, row] = max(tabl_input(:,2));


label = tabl_input(row);
name = feature_collection.names(label);

end

