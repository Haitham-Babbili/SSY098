function [label, name] = classify_church(image, feature_collection)
% - INPUT
% image, feature_collecition (from "church_data.mat")
% 
% - OUTPUT
% labe (index och church), name (name of church)
% 


[ ~ , descriptors] = extractSIFT(image); % funkar 
% coordinates


% the input descriptors need to be transposed to have the same amount of
% columns
correlations= matchFeatures(descriptors', feature_collection.descriptors', 'MatchThreshold', 100, 'MaxRatio', 0.7);

vote = tabulate(feature_collection.labels(correlations(:,2)));
% row = the row with maximun occuring votes
[~, row] = max(vote(:,2));


label = vote(row);
name = feature_collection.names(label);
end 