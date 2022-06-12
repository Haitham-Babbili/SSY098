function [pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate, tot_pts)
% affine transformation is written as:
% pts_tilde = A * pts + t
% pts is the pixel coordinates in source image (x,y) is 2x1 
% A decides how these points are to be transformed and is a 2x2 matrix
% t shifts the transformed points in +- x,y direction


outliers = round(tot_pts * outlier_rate);
inliers = tot_pts - outliers;

row1 = rand(2,2)*rand(1)*10;
row2 = randperm(10,2);
col1 = randperm(10,2)';

pts_inliers = [randperm(inliers,inliers); randperm(inliers,inliers)];
pts_outliers = [randperm(outliers,outliers)+length(inliers);... 
randperm(outliers,outliers)+length(inliers)];
pts = [pts_inliers pts_outliers];
A_true = 4*rand(2)-2;
t_true = randperm(100,2)';

pts_tilde_inliers=zeros(size(pts_inliers));


pts_tilde_inliers = (A_true * pts_inliers) + t_true;

pts_tilde = [pts_tilde_inliers pts_outliers];


