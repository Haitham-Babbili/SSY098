function warped = align_images( source, target, threshold, upright )
%ALIGN_IMAGES In this function, SIFT descriptors are extracted first,
%affine transformation matrix is estimated by the method RANSAC, after
%which refine the estimation by the linear least squares method,
%finally warp the image.
%   Input arguments:
%   - source : the sorce image that needs to be warped
%   - target : the target image which the source image is transformed to
%   - threshold : a threshold determins which points are outliers in the
%   RANSAC process, if the residual is larger than threshold, it can be
%   regarded as outliers, default value is 5
%   - upright : whether the images have the same orientation while the
%   SIFT descriptors are being extracted, default value is false
%   Output:
%   - warped : the warped image which has the same size as the target
% Author: Qixun Qu

% Set the default value of upright
if nargin < 4
    upright = false;
end

% Set the default value of threshold
if nargin < 3
    threshold = 5;
end

% Add folder 'sift' into the working path
addpath('sift')

% Extract SIFT descriptors from both source image and target image
[pts_source, desc_source] = extractSIFT(mean(source, 3), upright);
[pts_target, desc_target] = extractSIFT(mean(target, 3), upright);

% Match two descriptors and obtain the best matches
corrs = matchFeatures(desc_source', desc_target', ...
                      'MaxRatio', 0.8, 'MatchThreshold', 100);

% Form the points correspondences
pts_source = pts_source(:, corrs(:, 1));
pts_target = pts_target(:, corrs(:, 2));

% Run RANSAC to find inliers 
[~, ~, inliers] = ransac_fit_affine(pts_target, pts_source, threshold);

% Form new points correspondences by applying inliers
pts_source = pts_source(:, inliers);
pts_target = pts_target(:, inliers);

% Estimate affine transformation by the method of linear least squares
[A, t] = least_squares_affine(pts_target, pts_source);

% Warp the source image with the estimates affine transformation
warped = affine_warp(size(target), source, A, t);

end