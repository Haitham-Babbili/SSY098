function [ A, t ] = estimate_affine( pts, pts_tilde )
%ESTIMATE_AFFINE Estimate affine transformation by the given points
%correspondences.
%   Input arguments:
%   - pts : points in source image
%   - pts_tilde : points in target image
%   Output:
%   - A, t : the affine transformation, A is a 2x2 matrix that indicates
%   the rotation and scaling transformation, t is a 2x1 vector determines
%   the translation

% Get the number of corresponding points
point_num = size(pts, 2);

% Initialize the matrix M,
% M has 6 columns, since the affine transformation
% has 6 parameters in this case
M = zeros(2*point_num, 6);

for i = 1 : point_num
    
    % Form the matrix m
    M(2*i-1:2*i, :) = [pts(1,i), pts(2,i), 0, 0, 1, 0;
                       0, 0, pts(1,i), pts(2,i), 0, 1];
    
end

% Form the matrix b,
% b contains all known target points
b = pts_tilde(:);

warning('off')

% Solve the linear equation
theta = M \ b;

% Form the affine transformation
A = [theta(1), theta(2);
     theta(3), theta(4)];

t = theta(5:6);

end