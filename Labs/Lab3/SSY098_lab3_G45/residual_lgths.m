function residual_lgths = residual_lgths(A, t, pts, pts_tilde)

% This is to calculate the residual length (Euclidean distance) between 
%estimation and real target points. Estimation are calculated by the
%given source point and affine transformation (A & t).
% residual_lgths is the euclidean distance between estimated points and
% real target points

est_tilda= A*pts +t;

M=(est_tilda-pts_tilde);

pts_tilda=sum(M.^2, 1);
residual_lgths=sqrt(pts_tilda);

end

