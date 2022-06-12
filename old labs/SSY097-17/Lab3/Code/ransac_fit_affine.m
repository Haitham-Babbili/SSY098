function [ A, t, inliers ] = ransac_fit_affine( pts, pts_tilde, threshold )
%RANSAC_FIT_AFFINE Apply the method of RANSAC to obtain the estimation of
%affine transformation and inliers as well.
%   Input arguments:
%   - pts : points in the source image
%   - pts_tilde : points in the target image
%   - threshold : determing which points are inliers by comparing residual
%   with it
%   Output:
%   - A, t : estimated affine transformation
%   - inliers : indices of inliers that will be applied to refine the
%   affine transformation

% Set the number of corresponding points
K = 3;

% Initialize the number of inliers
inlier_num = 0;

% Initialize the affine transformation A and t,
% and a vector that stores indices of inliers
A = zeros(2);
t = zeros(2, 1);
inliers = [];

% Run iteration
for i = 1 : 10000
    
    % Randomly generate indices of points correspondences
    idx = randi(size(pts, 2), K, 1);
    % Estimate affine transformation by these points
    [A_temp, t_temp] = estimate_affine(pts(:, idx), pts_tilde(:, idx));
    
    % Calculate the residual by applying estimated transformation
    residuals = residual_lgths(A_temp, t_temp, pts, pts_tilde);
    
    % Obtain the indices of inliers
    inliers_temp = find(residuals < threshold);
    % Obtain the number of inliers
    inlier_num_temp =  length(inliers_temp);
    
    % Set affine transformation and indices og inliers in
    % one iteration which has the most of inliers
    if inlier_num_temp > inlier_num
        % Update the number of inliers
        inlier_num = inlier_num_temp;
        % Set returned value
        inliers = inliers_temp;
        A = A_temp;
        t = t_temp;
    end
    
end

end