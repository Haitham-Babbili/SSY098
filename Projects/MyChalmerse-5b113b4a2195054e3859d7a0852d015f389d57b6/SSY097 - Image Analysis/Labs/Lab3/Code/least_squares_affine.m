function [ A, t ] = least_squares_affine( pts, pts_tilde )
%LEAST_SQUARES_AFFINE Apply least squares to estimate affine
%transformation, which is exactly same as function estimate_affine().
%   Input arguments:
%   - pts : target points
%   - pts_tilde : source points
%   Outputes:
%   - A, t : estimated affine transformation
% Author: Qixun Qu

% Estimate affine transformation
[A, t] = estimate_affine(pts, pts_tilde);

end