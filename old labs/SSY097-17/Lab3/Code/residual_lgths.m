function residual_lengths = residual_lgths( A, t, pts, pts_tilde )
%RESIDUAL_LGTHS Compute residual length (Euclidean distance) between 
%estimation and real target points. Estimation are calculated by the
%given source point and affine transformation (A & t).
%   Input arguments:
%   - A, t : the estimated affine transformation calculated by least
%   squares method
%   - pts : the known source points
%   - pts_tilde : the known target points
%   Output:
%   - residual_lengths : Euclidean distance between estimated points and
%   real target points

% Calculate estimated points: 
% pts_esti = A * pts + t
pts_esti = bsxfun(@plus, A * pts, t);

% Calculate the residual length between estimated points
% and real target points as follows:
%        /-----------------------
% r = /\/ (x - x')^2 + (y - y')^2
residual_lengths = sqrt(sum((pts_esti - pts_tilde).^2, 1));

end