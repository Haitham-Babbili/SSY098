function [ label, name ] = classify_church( image, feature_collection )
%CLASSIFY_CHURCH Classify the input image that contains church.
%   Input argument:
%   - image : an image has a church in it and needs to be classified
%   - feature_collection : a training set that has plenty of descriptors
%   Outputs:
%   - label : an index shows which group the image is part of
%   - name : the name of a city where the church in the image locates in
% Author: Qixun Qu

% Calculate the descriptor of input image by applying vlfeat
[~, descriptors] = extractSIFT(image);

% Match the descriptor with descriptors in training set, store the
% best-matches in corrs
% MatchThreshold, 100 : two matched descriptors should be exactly same
% MaxRatio, 0.7 :       distance to the best match
%                     -------------------------------  <= 0.7
%                     distance to the next best match
corrs = matchFeatures(descriptors', feature_collection.descriptors',...
                      'MatchThreshold', 100, 'MaxRatio', 0.7);

% Calculate frequency table for all matches, the result looks like
%     Label  Occurrence  Frequency 
%       1       138       75.4098
%       2        10        5.4645
%       3         6        3.2787
%       4        15        8.1967
%       5        14        7.6503
% obtain the label that has the largest occurrence number
% this number is the label for the input image
tbl = tabulate(feature_collection.labels(corrs(:,2)));
[~, row] = max(tbl(:,2));
label = tbl(row);

% Get the name of city where the churce locates in
name = feature_collection.names(label);

end