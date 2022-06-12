function mean_error = evaluate_transformation(pts, pts_tilde, A, t, outlier_rate)
    N = length(pts);
    outliers = round(N*outlier_rate);
    pts_inliers = pts(1:end-outliers,:)
    pts_tilde_inliers = pts_tilde(1:end-outliers,:)
    mean_error = pts_tilde_inliers - A*pts_inliers+t;

end

