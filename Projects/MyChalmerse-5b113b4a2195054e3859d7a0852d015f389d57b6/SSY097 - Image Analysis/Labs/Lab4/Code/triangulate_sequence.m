%% Lab 4 - Ex 4.4 & 4.5
% Run RANSAC to triangulate 3D points from given data.
% This script may run for 10 minuts, you may run the last
% section which plots reconstruction result from saved data.
% Author: Qixun Qu

%% Clean Environment
clc
clear
close all

%% Ex 4.5 - Triangulate Sequence
% Load data that provides plenty of camera matrix
% and known image points
load data/sequence.mat

%% Run RANSAC
% Obtain the number of 3D points need to be reconstructed
pts_num = length(triangulation_examples);

% Initialize the matrix contains all
% estimated 3D points
Us = zeros(3, pts_num);

% Initialize a vector stores the number
% of inliers for each 3D point
nbr_inliers = zeros(pts_num, 1);

h = waitbar(0,'Running RANSAC...');
for i = 1 : pts_num
    
    % Extract the ith camera matrix and known image points
    Psi = triangulation_examples(i).Ps;
    usi = triangulation_examples(i).xs;

    % Estimate 3D points by RANSAC
    [Us(:, i), nbr_inliers(i)] = ransac_triangulation(Psi, usi);
    
    waitbar(i/pts_num)

end
close(h)

% Save refined points and the number of inliers
% for each points into file
save('data/Us.mat', 'Us')
save('data/nbr_inliers.mat', 'nbr_inliers')

%% Plot Result form File
% Load outputs from files
load 'data/Us.mat'
load 'data/nbr_inliers'

% Find indices for points who has at least 2 inliers
Us = Us(:, nbr_inliers >= 2);

% Clean refined points, remove some points with
% rather high and rather low values
Uc = clean_for_plot(Us);

% Plot points
figure
scatter3(Uc(1,:), Uc(2,:), Uc(3,:), 'k.')
axis equal; axis off
view(-170, 5)
