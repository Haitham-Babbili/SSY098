function [ pts, pts_tilde, A, t ] = affine_test_case( outlier_rate )
%AFFINE_TEST_CASE Randomly generate a test case of affine transformation.
%   Input argument:
%   - outlier_rate : the percentage of outliers in test case, default is 0
%   Outputs:
%   - pts : warped points
%   - pts_tilde : source points that wll be transformed
%   - A, t : parameters of affine transformation, A is a 2x2 matrix, t is
%   a 2x1 vector, both of them are created randomly
% Author: Qixun Qu

% Set the default value of outlier rate
% if it is not input
if nargin < 1
    outlier_rate = 0;
end

% Randomly generate affine transformation
% A is a 2x2 matrix, the range of each value is from -2 to 2
A = 4 * rand(2) - 2;
% t is a 2x1 matrix, the range of each value is from -10 to 10
t = 20 * rand(2, 1) - 10;

% Set the number of points in test case
num = 1000;

% Compute the number of outliers and inliers respectively
outliers = round(num * outlier_rate);
inliers = num - outliers;

% Gernerate source points whose scope from (0,0) to (100,100)
pts = 100 * rand(2, num);
% Initialize warped points matrix
pts_tilde = zeros(2, num);

% Compute inliers in warped points matrix by applying A and t
pts_tilde(:, 1:inliers) = bsxfun(@plus, A * pts(:, 1:inliers), t);

% Generate outliers in warped points matrix
if outlier_rate > 0
    pts_tilde(:, inliers+1:end) = randi(100, 2, outliers);
end

% Reset the order of warped points matrix,
% outliers and inliers will scatter randomly in test case
rnd_idx = randperm(num);
pts = pts(:, rnd_idx);
pts_tilde = pts_tilde(:, rnd_idx);

end