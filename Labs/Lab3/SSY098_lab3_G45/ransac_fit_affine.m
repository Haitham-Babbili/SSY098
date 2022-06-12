function [A,t,inliers] = ransac_fit_affine(pts, pts_tilde, threshold)
% -threshold : determing which points are inliers by comparing residual
%   with it
%inliers :  These are indices of inliers that will be later used to
%    refine the affine transformation

K=3;  % points of correspondence

numb_inlier=0; %Initial number of inlier

pts_size=size(pts,2); % size of pts

A=zeros(2); % initial element of A

t=zeros(2,1); % initial element of t

inliers=[]; % initial element of inlier.This is a vector that stores indices of inliers


% Run iteration
for i=1:100
    est_pts= randi(pts_size,K,1);
    pts_new = pts(:, est_pts);
    pts_tilde_new= pts_tilde(:, est_pts);
    [A_N, t_N] = estimate_affine(pts_new, pts_tilde_new); % get affine transformation
    
    residuals = residual_lgths(A_N, t_N, pts, pts_tilde); % get the residuals point
    
    inliers_New=find(residuals < threshold); % find new residuals lower than threshold
    
    inliers_New_size=length(inliers_New); % get the amount of resduals lower than threshold
    
    if inliers_New_size>numb_inlier % update inlier number as we continue to compute
        numb_inlier = inliers_New_size;
        inliers = inliers_New;
        A=A_N;
        t=t_N;
    end

end


end

