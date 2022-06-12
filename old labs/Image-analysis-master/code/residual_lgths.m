function res_lghts=residual_lgths(A,t,pts,pts_tilde)
pts_delta=((A*pts+t)-pts_tilde);
res_lghts=sqrt(sum(pts_delta.^2,1));
end