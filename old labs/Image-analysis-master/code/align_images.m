function warped=align_images(source,target)
target_size=size(mean(target,3));
% extract features from the two images
[pts_s, descs_s]=extractSIFT(mean(source,3));
[pts_t, descs_t]=extractSIFT(mean(target,3));
corrs=matchFeatures(descs_s',descs_t','MaxRatio',0.8,'MatchThreshold',100);
% input into RANSAC
[A,t]=ransac_fit_affine(pts_t(:,corrs(:,2)),pts_s(:,corrs(:,1)),1e-2); % good threshold?

%warp
warped=affine_warp(target_size,source,A,t);
end