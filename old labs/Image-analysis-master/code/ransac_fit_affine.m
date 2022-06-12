function [A,t]=ransac_fit_affine(pts,pts_tilde,threshold)
m=size(pts,2);
if(m<3)
    error('too few points to do anything')
end
n=3;  % minimal amount
k=0;
epsilon=0.5; % inlier ratio, initial; assume at least as many inliers as outliers
eta=0.99;    %correct?
kmax=log(eta)/log(1-epsilon.^n);
num_inliers=0;
best_A=zeros(2);
best_t=zeros(2,1);
while k<kmax
    pts_est=randperm(m,n);
    [A,t]=estimate_affine(pts(:,pts_est),pts_tilde(:,pts_est));
    % estimate support of model 
    res=residual_lgths(A,t,pts,pts_tilde);
    num_inliers_new=size(find(res<=threshold),1); % find those residuals smaller than the threshold and count how many there are
    if num_inliers<num_inliers_new % if better model
        % update parameters
        num_inliers=num_inliers_new;
        best_A=A;
        best_t=t;
        epsilon=num_inliers/m;
        kmax=log(eta)/log(1-epsilon.^n);
    end
    k=k+1;
end
A=best_A;
t=best_t;
end