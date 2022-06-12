function [A,t,inliers]=ransac_fit_affine(pts,pts_tilde,threshold)
m=size(pts,2);
n=3;  % minimal amount
k=0;
kmax=10000; % arbitrarily chosen, can be made more adaptive
inliers_best=[];
num_inliers=0;
best_A=zeros(2);
best_t=zeros(2,1);        
while k<kmax
    % take k random points and estimate transform
    pts_est=randperm(m,n);
    [A,t]=estimate_affine(pts(:,pts_est),pts_tilde(:,pts_est));
    % estimate support of model 
    res=residual_lgths(A,t,pts,pts_tilde);
    inliers_new=find(res<=threshold);
    num_inliers_new=size(inliers_new,1); % find those residuals smaller than the threshold and count how many there are
    if num_inliers<num_inliers_new % if it is a better model, update parameters
        inliers_best=inliers_new;
        num_inliers=num_inliers_new;
        best_A=A;
        best_t=t;
    end
    k=k+1;
end
inliers=inliers_best;
A=best_A;
t=best_t;
end