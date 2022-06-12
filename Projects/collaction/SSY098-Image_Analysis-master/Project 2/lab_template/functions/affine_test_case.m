function [pts,pts_tilde,A_true,t_true] = affine_test_case(outlier_rate)
    N = 3;
    outliers = round(N*outlier_rate);
    inliers = N - outliers;
    pts_inliers = [randperm(640,inliers); randperm(480,inliers)];
    pts_outliers = [randperm(outliers,outliers)+length(inliers); randperm(outliers,outliers)+length(inliers)];
    
    pts = [pts_inliers pts_outliers];
    A_true = rand(2, 2);
    t_true = rand(2, 1);
    
    var = 0;
    noise = var * randn(size(pts));
    
    pts_tilde_inliers = A_true*pts_inliers+t_true;
    pts_tilde = [pts_tilde_inliers pts_outliers] + noise;
end

