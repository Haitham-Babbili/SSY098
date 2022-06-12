function [label, name] = classify_church(image, feature_collection)

[coords, descriptors] = extractSIFT(image);

corrs = matchFeatures(descriptors', feature_collection.descriptors', 'MatchThreshold', 100, 'MaxRatio', 0.7);
        
tbl = tabulate(feature_collection.labels(corrs(:,2)))
[~, row] = max(tbl(:,2));
label = tbl(row);
name = feature_collection.names(label);
end