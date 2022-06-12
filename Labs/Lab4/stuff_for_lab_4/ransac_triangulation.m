function [U, nbr_inliers] = ransac_triangulation(Ps, us, threshold)


if nargin < 3
    threshold = 5;
end


% The Minimum K value used in one iteration
K = 2;

% get the length of the cameras
N = length(Ps);

% Initialize U for 3D points
intial_U = zeros(3, 1);

% Initialize the number of inliers
intial_inliers = 0;

for i = 1:size(Ps,2)*(size(Ps,2)-1)/2


    idx = randi(N, K, 1);
    Ps_pt = Ps(idx);
    us_pt = us(:, idx);
    
    temprory_U = minimal_triangulation(Ps_pt, us_pt);
    if sum(isnan(temprory_U)) > 0
        continue
    end
    
   
    errors = reprojection_errors(Ps, us, temprory_U);
    
    temprory_inliers = length(find(errors < threshold));
    if temprory_inliers > intial_inliers
        intial_inliers = temprory_inliers;
        intial_U = temprory_U;
    end 
    
end


U = intial_U;
nbr_inliers = intial_inliers;

end


