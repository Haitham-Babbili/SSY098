function [ A, t ] = least_squares_affine( pts, pts_tilde )
%LEAST_SQUARES_AFFINE Apply least squares to estimate affine
%transformation, which is exactly same as function estimate_affine().
%   Input arguments:
%   - pts : source points
%   - pts_tilde : target points
%   Outputes:
%   - A, t : estimated affine transformation

% Estimate affine transformation
[A, t] = estimate_affine(pts, pts_tilde);

end