function warped = align_images(source, target, threshold, upright)

%[points, descriptors] = extractSIFT(img, true);
[pts_source, descs_source] = extractSIFT(source, upright);
[pts_target, descs_target] = extractSIFT(target, upright);

%[pts_source, descs_source] = extractSIFT(source);
%[pts_target, descs_target] = extractSIFT(target);

corrs = matchFeatures(descs_source', descs_target', 'MaxRatio', 0.8,...
 'MatchThreshold', 100);

pts = pts_target(:,corrs(:,2));
pts_tilde = pts_source(:,corrs(:,1));

[~,~,inliers] = ransac_fit_affine(pts, pts_tilde, threshold);

pts = pts(:,inliers);
pts_tilde = pts_tilde(:,inliers);

target_size = size(target);

[A, t] = least_squares_affine(pts, pts_tilde);

warped = affine_warp(target_size, source, A, t);

end