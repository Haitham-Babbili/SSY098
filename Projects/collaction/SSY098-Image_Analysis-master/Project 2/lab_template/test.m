outlier_rate = 0.1
[pts,pts_tilde,A_true,t_true] = affine_test_case(outlier_rate)
[A, t] = estimate_affine(pts, pts_tilde)

mean_error = evaluate_transformation(pts, pts_tilde, A, t, outlier_rate)