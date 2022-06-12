function warped = align_images(source, target)


% get features to the two images
mean_source= mean(source,3);
mean_target= mean(target,3);
[pts_s, descs_s]=extractSIFT(mean_source);
[pts_t, descs_t]=extractSIFT(mean_target);

% match them
corrs=matchFeatures(descs_s',descs_t','MaxRatio',0.8,'MatchThreshold',1e2);

%RANSAC
pts= pts_s(:,corrs(:,1));
pts_tilda= pts_t(:,corrs(:,2));

[A,t]=ransac_fit_affine(pts_tilda,pts,1e2);

%warp

target_size=size(mean(target,3));
warped = affine_warp(target_size, source, A, t);
end

