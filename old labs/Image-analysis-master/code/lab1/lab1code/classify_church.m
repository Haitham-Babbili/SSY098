function [label,name]=classify_church(image,feature_collection)
[coords1, desc1]=extractSIFT(image);
corrs=matchFeatures(desc1',feature_collection.descriptors','MatchThreshold',100,'MaxRatio',0.7);
K=size(corrs,1);
L=zeros(K,1);
for i=1:K
    L(i)=feature_collection.labels(corrs(i,2));
end
% find most occuring label
HIST=hist(L,5);
[M,I]=max(HIST);
label=I;
name=feature_collection.names{I};
end