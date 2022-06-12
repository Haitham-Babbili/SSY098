function warped=align_images(source,target,threshold,upright)
target_size=size(mean(target,3));
% extract features from the two images
if(upright)
    [pts_s, descs_s]=extractSIFT(mean(source,3),true);
    [pts_t, descs_t]=extractSIFT(mean(target,3),true);
else
    [pts_s, descs_s]=extractSIFT(mean(source,3));
    [pts_t, descs_t]=extractSIFT(mean(target,3));
end
corrs=matchFeatures(descs_s',descs_t','MaxRatio',0.8,'MatchThreshold',100);
% input into RANSAC
[~,~,inliers]=ransac_fit_affine(pts_t(:,corrs(:,2)),pts_s(:,corrs(:,1)),threshold); 
% find estimate from only inliers
pts_source=pts_s(:,inliers);
pts_target=pts_t(:,inliers);

[A,t]=least_squares_affine(pts_target,pts_source);
%warp
warped=affine_warp(target_size,source,A,t);
end