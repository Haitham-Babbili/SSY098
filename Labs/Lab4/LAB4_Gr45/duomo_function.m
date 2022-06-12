function duomo_function(pts, pts_tilde)
% This is for Exercise 4.13
% Triangulate points from two images taken from different positions by
% the same camera. This script will run for a while, you may just run
% the last section that plots the saved data.



% Set the default value of threshold 
if nargin < 3
    threshold = 5;
end


addpath('sift') % % First add the folder 'sift' into our working path

load 'duomo.mat' % load matrix

% add the image to the function path
pts = imread('duomo.jpg');
pts_tilde = imread('duomo_tilde.jpg');


[pts_source, desc_source] = extractSIFT(mean(pts, 3));  % add sift to image bath 
[pts_target, desc_target] = extractSIFT(mean(pts_tilde, 3));

% Then, match two descriptors and obtain the best matches
corrs = matchFeatures(desc_source', desc_target', 'Method', 'Approximate', 'MaxRatio', 0.8, 'MatchThreshold', 100);

% Form the points correspondences
u = pts_source(:, corrs(:, 1));
u_tilde = pts_target(:, corrs(:, 2));


% convert camera cell into matrix
Ps_element =[P P_tilde];

length_cell = length(Ps_element(:)) / 12;

% creat Ps as empty tow cell
Ps = cell(1, length_cell);

% Get Ps element from the cameras matrix 
for i = 1 : length_cell

    Ps{i} = reshape(Ps_element(12*i-11:12*i), 3, 4);
        
end


% Create RANSAC to identify the 3D point

N=length(u); % calculate camera matrix number


Uhat = zeros(3, N); % create empty 3D point matrix


nbr_inliers = zeros(N, 1); % create empty vector matrix  for inlier 3D points


for i = 1 : N
    
    % merge the known 2 image points
    us = [u(:, i) u_tilde(:, i)];
    
    % Use RANSAC to identify the 3D point
    [Uhat(:, i), nbr_inliers(i)] = ransac_triangulation(Ps, us, 10);
    
end


% Reshape the matrix for Known points
index = find(nbr_inliers >= 2); % get index points to last  two inliers 

Uhat = Uhat(:, index); % update the index points

u = u(:, index); % create new points for the new image
u_tilde = u_tilde(:, index);

colors = impixel(pts, round(u(1, :)), round(u(2, :))) / 255; % get colors for the this image 

% Create again the 3D Triangulated points
N = length(Uhat);

% Initialize the matrix to store refined points
Ur = zeros(3, N);

for i = 1 : N
    
    % Combine two reformed image points
    us = [u(:, i) u_tilde(:, i)];
    
    % Refine the triangulated points by Gauss-Newton method
    Ur(:, i) = refine_triangulation(Ps, us, Uhat(:, i));
    
end

% Clean and remove, then re-discover the new point and then save it  
[Ur, removed_index] = clean_for_plot(Ur);


colors(removed_index == 1, :) = [];


save('U_new.mat', 'Ur')
save('U_colored.mat', 'colors')
end

