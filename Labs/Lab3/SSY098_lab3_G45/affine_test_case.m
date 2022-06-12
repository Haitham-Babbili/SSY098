function [pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate)
% outlier_rate is the percentage of outliers in the test case and we made
% it to be zero (0) here
% pts is the source points, or pixels, to be transformed
% pts_tilde is for the warped points
% Mathematically; pts_tilde = A * pts + t
% Affine transformation parameter, A,  is a 2x2 matrix, randomzied
% t shifts the transformed points in (x,y) direction. It is a vector 2x1, 
%  randomized

% Randomly generate affine transformation
k=randi([3 100]); % random amount of points in the test case with minimume of k=3

pts = 100 * rand(2, k); 
pts_tilde=zeros(2,k);

A_true=4*rand(2)-2;
t_true = randperm(10,2)';

for i=1:k
    if(outlier_rate>0) % if this is an outlier
        pts_tilde(:,i)=[rand(1)*max(pts(1,:)); rand(1)*max(pts(2,:))]; % random point in bounds of pts
    else
        pts_tilde(:,i)=A_true*pts(:,i)+t_true;
    end
end

end

