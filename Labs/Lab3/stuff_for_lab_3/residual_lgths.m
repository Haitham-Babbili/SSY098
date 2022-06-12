function residual_lgths = residual_lgths(A, t, pts, pts_tilde)

est_delta= A*pts +t;

M=(est_delta-pts_tilde);

pts_delta=sum(M.^2, 1);
residual_lgths=sqrt(pts_delta);

end

