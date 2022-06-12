function [pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate)
% this function generates a test case for estimating an affine transformation.
% pts random point in sourse image 2x1
% pts_tilde is a wrapt point= A * pts + t
% t is affine shift transforme point on x&y axis and it is 2X1 vectoe 
% A is affine transforme point = 2X2 matrex point


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

