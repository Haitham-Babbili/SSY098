function warped = align_images(source, target, threshold, upright)


if nargin < 4
    upright= false;
end

if nargin < 4
    threshold= 5;
end


addpath('sift')
% get features to the two images
mean_source= mean(source,3);
mean_target= mean(target,3);
[pts_s, descs_s]=extractSIFT(mean_source, upright);
[pts_t, descs_t]=extractSIFT(mean_target, upright);

% match them
corrs=matchFeatures(descs_s',descs_t','MaxRatio',0.8,'MatchThreshold',threshold);

%RANSAC
pts_s = pts_s(:,corrs(:,1));
pts_t = pts_t(:,corrs(:,2));

[~,~,inliers]=ransac_fit_affine(pts_t,pts_s,threshold);

%warp
% Form new points correspondences by applying inliers
pts_s = pts_s(:, inliers);
pts_t = pts_t(:, inliers);

% Estimation of affine transformation by linear least squares
[A, t] = least_squares_affine(pts_t, pts_s);

% Finally, warp the source image with the estimates of affine transformation

warped = affine_warp(size(target), source, A, t);

end

