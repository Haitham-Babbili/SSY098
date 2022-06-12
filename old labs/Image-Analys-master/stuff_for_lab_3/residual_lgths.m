function residual_lgths = residual_lgths(A, t, pts, pts_tilde)
%calculates the differance between the true pts_tilde and the pts_tilde
%that is calculated after trying to find the unknown parameters in the
%affine transformation.
pts_tilde_est = A * pts + t;

sq_diff_sum = sum((pts_tilde_est - pts_tilde).^2, 1);

residual_lgths = sqrt(sq_diff_sum);

end