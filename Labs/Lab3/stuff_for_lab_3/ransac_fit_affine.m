function [A,t] = ransac_fit_affine(pts, pts_tilde, threshold)

K=3;  % corrdinats number

b=0;

num_inlier=0; %number of inlier

pts_size=size(pts,2); % size of pts

ini_A=zeros(2); % initial element of A

ini_t=zeros(2,1); % initial element of t

inlier_elemen=[]; % initial element of inlier

max_inlier=500;

while max_inlier >= b
    est_pts= randperm(pts_size,K);
    pts_new = pts(:, est_pts);
    pts_tilde_new= pts_tilde(:, est_pts);
    [A_N, t_N] = estimate_affine(pts_new, pts_tilde_new); % get affine transformation
    
%     residuals = residual_lgths(A_N, t_N, pts, pts_tilde); % get the residuals point
    
%     inliers_New=find(residuals<=threshold); % find new residuals lower than threshold
%     
%     inliers_New_size=size(inliers_New,1); % get the amount of resduals lower than threshold
%     
%     if num_inlier<inliers_New_size % if it is a better model, update parameters
%         inlier_elemen = inliers_New;
%         num_inlier=inliers_New_size;
%         ini_A=A_N;
%         ini_t=t_N;
%     end
    b=b+1;
end

% A =ini_A;
% 
% t=ini_t;


A =A_N;

t=t_N;


end

