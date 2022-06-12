%% triangulate sequence
Ps={triangulation_examples.Ps};
us={triangulation_examples.xs};
m=1000;%size(Ps,2); % size of camera cell array
nbr_inliers=zeros(m,1);
U=zeros(3,m);
for i=1:m
    [U(:,i),nbr_inliers(i)]=ransac_triangulation(Ps{i},us{i},5); 
end

