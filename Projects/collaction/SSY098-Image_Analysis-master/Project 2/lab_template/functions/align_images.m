function warped = align_images(source, target, threshold, upright)
    [target_pts, target_desc] = extractSIFT(mean(target,3),upright);
    [source_pts,source_desc] = extractSIFT(mean(source,3),upright); 

    corrs = matchFeatures(target_desc', source_desc', 'MaxRatio', 0.8, 'MatchThreshold', 100);
    sort_target_pts = target_pts(:,corrs(:,1));
    sort_source_pts = source_pts(:,corrs(:,2));
    [A_prim,t_prim] = ransac_fit_affine(sort_target_pts,sort_source_pts,threshold);
    residual = residual_lgths(A_prim,t_prim,sort_target_pts,sort_source_pts);
    inlier_index = find(residual <= threshold);
    inlier_s_p = sort_source_pts(:,inlier_index);
    inlier_t_p = sort_target_pts(:,inlier_index);
    [A,t] = least_squares_affine(inlier_t_p,inlier_s_p);
    
    target_size = size(target);
    warped = affine_warp(target_size,source,A,t);
end

