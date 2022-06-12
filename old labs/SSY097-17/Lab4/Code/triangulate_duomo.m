%% Lab 4 - Ex 4.13
% Triangulate points from two images taken from different positions by
% the same camera. This script will run for a while, you may just run
% the last section that plots the saved data.

%% Clean Environment
clc
clear
close all

%% Load Data
% Load two camera matrix
load 'data/duomo.mat'

% Read two images
img1 = imread('pic/duomo.jpg');
img2 = imread('pic/duomo_tilde.jpg');

%% Obtian SIFT Descriptor for Both Images
addpath('sift')

% Extract SIFT descriptors for both images
[coor1, desc1] = extractSIFT(mean(img1, 3));
[coor2, desc2] = extractSIFT(mean(img2, 3));

% Match two descriptors, get the match points
corrs = matchFeatures(desc1', desc2', 'Method', 'Approximate', ...
                                      'MaxRatio', 0.9, ...
                                      'MatchThreshold', 100);

%% Form Matrix for Known Points
% Extract matched points as known points
u = coor1(:, corrs(:, 1));
u_tilde = coor2(:, corrs(:, 2));

% Form a cell contains camera matrix
Ps = convert_to_cell([P P_tilde]);

%% Run RANSAC to Estimate 3D Points
% Obtain the number of camera matrix
pts_num = size(u, 2);

% Initialize the matrix contains all
% estimated 3D points
Uhat = zeros(3, pts_num);

% Initialize a vector stores the number
% of inliers for each 3D point
nbr_inliers = zeros(pts_num, 1);

h = waitbar(0, 'Running RANSAC...');
for i = 1 : pts_num
    
    % Combine two known image points
    us = [u(:, i) u_tilde(:, i)];
    
    % Estimate 3D points by RANSAC
    [Uhat(:, i), nbr_inliers(i)] = ransac_triangulation(Ps, us, 10);
    
    waitbar(i/pts_num)
end
close(h)

%% Reform Matrix for Known Points
% Find indices for points who has at least 2 inliers
inliers_idx = find(nbr_inliers >= 2);

% Update the estimated points
Uhat = Uhat(:, inliers_idx);

% Reform the known image points
u = u(:, inliers_idx);
u_tilde = u_tilde(:, inliers_idx);

% Extract colors for known points from one image
colors = impixel(img1, round(u(1, :)), round(u(2, :))) / 255;

%% Refine Triangulated 3D Points
% Obtain the number of 3D points
pts_num = size(Uhat, 2);

% Initialize the matrix to store refined points
Ur = zeros(3, pts_num);

for i = 1 : pts_num
    
    % Combine two reformed image points
    us = [u(:, i) u_tilde(:, i)];
    
    % Refine the triangulated points by Gauss-Newton method
    Ur(:, i) = refine_triangulation(Ps, us, Uhat(:, i));
    
end

%% Clean and Save Output
% Clean refined points, remove some points with
% rather high and rather low values
[Ur, removed_idx] = clean_for_plot(Ur);

% Clean colors for removed points
colors(removed_idx == 1, :) = [];

% Save refined points and their colors into file
save('data/Ur.mat', 'Ur')
save('data/colors.mat', 'colors')

%% Plot 3D Points
% Load outputs from files
load 'data/Ur.mat'
load 'data/colors.mat'

% Plot points
figure
scatter3(Uhat(1,:), Uhat(2,:), Uhat(3,:), 30, colors ,'.')
axis equal; axis off
view(0, -90)
