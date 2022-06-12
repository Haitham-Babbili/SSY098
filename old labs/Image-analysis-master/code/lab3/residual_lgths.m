function res_lghts=residual_lgths(A,t,pts,pts_tilde)
% difference between estimate and known coordinates
pts_delta=((A*pts+t)-pts_tilde);
% euclidian distance
res_lghts=sqrt(sum(pts_delta.^2,1));
end