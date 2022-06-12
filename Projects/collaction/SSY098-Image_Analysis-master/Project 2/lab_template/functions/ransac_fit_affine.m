function [A,t] = ransac_fit_affine(pts, pts_tilde, threshold)
    best_inliers = 0;
    K = 3;
    for i = 1:1000
        index = randperm(size(pts,2),K);

        subset = pts(:,index(:));
        subset_tilde = pts_tilde(:,index(:));

        [A_prim,t_prim] = estimate_affine(subset,subset_tilde);
        residual = residual_lgths(A_prim,t_prim,pts,pts_tilde);

        inlierIndex = find(residual <= threshold);

        nr_inliers = length(inlierIndex);

        if best_inliers < nr_inliers
             best_inliers = nr_inliers;
             A = A_prim;
             t = t_prim;
        end
    end
end