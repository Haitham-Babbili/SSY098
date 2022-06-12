function [U, nbr_inliers]=ransac_triangulation(Ps,us,threshold) % threshold 5 should be ok
% take the collection of camera views and related points and use
    % RANSAC to estimate a point in 3D-space
    
    % minimal triangulation takes two cameras and two points
    n=2;  % minimal amount
    
    kmax=500; % arbitrarily chosen, can be made more adaptive       
    
    M=size(Ps,2); % how many views?
    num_inliers=0;
    best_U=zeros(3,1);
    k=0;
while k<kmax
    % take 2 random views and estimate 3D point
    
    pts_est=randperm(M,n);
    views=Ps(pts_est);   
    points=us(:,pts_est);
    
    U=minimal_triangulation(views,points);
    
    % calculate projection errors
    res=reprojection_errors(Ps,us,U);
    inliers_new=find(res<=threshold);
    num_inliers_new=size(inliers_new,1); % find those residuals smaller than the threshold and count how many there are
    if num_inliers<num_inliers_new % if it is a better model, update parameters
        num_inliers=num_inliers_new;
        best_U=U;
    end
    k=k+1;
end
nbr_inliers=num_inliers;
U=best_U;



end