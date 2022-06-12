function [A,t]=least_squares_affine(pts,pts_tilde)
% same as estimate affine since it already is
% the least square approximation.

[A,t]=estimate_affine(pts,pts_tilde);
end