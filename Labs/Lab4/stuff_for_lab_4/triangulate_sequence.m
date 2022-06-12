function triangulate_sequence(Ps, us)

load sequence.mat
Ps={triangulation_examples.Ps};
us={triangulation_examples.xs};

M=1000;%length(Ps); % size of camera cell array

nbr_inliers=zeros(M,1);

U=zeros(3,M);

for i=1:M
    [U(:,i),nbr_inliers(i)]=ransac_triangulation(Ps{i},us{i},5); 
end

save('U.mat', 'U')
save('nbr_inliers.mat', 'nbr_inliers')
end

