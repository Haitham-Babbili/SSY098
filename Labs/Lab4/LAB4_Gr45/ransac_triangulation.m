function [U, nbr_inliers] = ransac_triangulation(Ps, us, threshold)
%   
%  U is the reconstructed 3D image points
%   nbr_inliers is the number of inliers of each 3D image points

% Default threshold is set as 5
if nargin < 3
    threshold = 5;
end


% The Minimum K value used in one iteration
K = 2;

% Get the length of the cameras
N = length(Ps);

% Initialize U for 3D points
intial_U = zeros(3, 1);

% Initialize the number of inliers
intial_inliers = 0;

for i = 1:size(Ps,2)*(size(Ps,2)-1)/2


    index = randi(N, K, 1);
    Ps_pt = Ps(index);
    us_pt = us(:, index);
    
    temporary_U = minimal_triangulation(Ps_pt, us_pt);
    if sum(isnan(temporary_U)) > 0
        continue
    end
    
   
    errors = reprojection_errors(Ps, us, temporary_U);
    
    temporary_inliers = length(find(errors < threshold));
    if temporary_inliers > intial_inliers
        intial_inliers = temporary_inliers;
        intial_U = temporary_U;
    end 
    
end


U = intial_U;
nbr_inliers = intial_inliers;

end


