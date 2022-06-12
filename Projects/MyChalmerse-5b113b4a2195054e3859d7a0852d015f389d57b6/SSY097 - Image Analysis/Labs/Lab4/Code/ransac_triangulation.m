function [ U, nbr_inliers ] = ransac_triangulation( Ps, us, threshold )
%RANSAC_TRIANGULATION Triangulate 3D points by RANSAC method.
%   Input arguments:
%   - Ps : a cell contains n 3x4 camera matrix,
%     the ith matrix can be presented as
%        |<-- ai -->|   | ai1 ai2 ai3 ai4 |
%   Pi = |<-- bi -->| = | bi1 bi2 bi3 bi4 |
%        |<-- ci -->|   | ci1 ci2 ci3 ci4 |
%   - us : a 2xn matrix contains n known image points,
%   the ith point is [xi; yi]
%   - threshold : determing which known points are inliers
%   by comparing reprojection errors with it, default is 5
%   Output:
%   - U : the reconstructed 3D points
%   - nbr_inliers : the number of inliers of each 3D points
% Author: Qixun Qu

% Set the default value
% for threshold
if nargin < 3
    threshold = 5;
end

% Set the number of corresponding points
% used in one iteration
K = 2;

% Obtain the number of camera matrix
pts_num = length(Ps);

% Initialize the 3D points
U = zeros(3, 1);

% Initialize the number of inliers
nbr_inliers = 0;

for i = 1 : 100

    % In each iteration, randomly extract two examples
    % form dataset of camera matrix and known points
    idx = randi(pts_num, K, 1);
    Ps_pt = Ps(idx);
    us_pt = us(:, idx);
    
    % Estimate the 3D points by minimal solver
    U_temp = minimal_triangulation(Ps_pt, us_pt);
    if sum(isnan(U_temp)) > 0
        continue
    end
    
    % Calculate the reprojection error between known points
    % and reprojected points
    errors = reprojection_errors(Ps, us, U_temp);
    
    % Calculate the number of inliers
    % Return the 3D point which has the most inliers
    nbr_inliers_temp = length(find(errors < threshold));
    if nbr_inliers_temp > nbr_inliers
        nbr_inliers = nbr_inliers_temp;
        U = U_temp;
    end 
    
end

end