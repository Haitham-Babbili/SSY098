function residual_lgths = residual_lgths(A, t, pts, pts_tilde)
    residual_lgths = sqrt(sum(((A*pts+t)-pts_tilde).^2,1));
end

