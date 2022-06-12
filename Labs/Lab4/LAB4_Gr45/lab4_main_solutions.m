%% Group 45

%% Lab4 Camera Geometry

clc
clear all 
close all

%% 4.1

sigma= 0;
% sigma= 1;
% sigma= 10;
[Ps, us, U_true] = triangulation_test_case(sigma);

U = minimal_triangulation(Ps, us);


display(U_true)
display(U)

%% 4.2
positive = check_depths(Ps, U);
display(positive)

%% 4.3
errors = reprojection_errors(Ps, us, U);
display(errors)

%% 4.4 function [U, nbr_inliers] = ransac_triangulation(Ps, us, threshold)

%% 4.5

triangulate_sequence(Ps, us)

%load 
load 'U.mat'
load 'nbr_inliers.mat'

U = U(:, nbr_inliers >= 2);

% Clean up the data 
Uc = clean_for_plot(U);

% Plot triangulated points
% It is Arc de Triomphe in the plot
figure (1)
scatter3(Uc(1,:), Uc(2,:), Uc(3,:), 'k.')
axis equal; axis off

view(-172, 4)
%view(-170, 5)
%view(-168, 5)
%view(-160,4)
%view(-172, 5)
%view(-400,5)

% The resulting image is not distinct enough for accurate recognition. 
% It is a collection of dots that seems to form the shape of the building

%% 4.6 
% The answer is in the included pdf file

%%  4.7  all_residuals = compute_residuals(Ps, us, U);

%% 4.8 - Jacobian Matrix
% Generate the formula of Jacobian matrix
% The answer is in the included pdf file

%% 4.9 jacobian = compute_jacobian(Ps, U);

%% 4.10 

load 'gauss_newton.mat'

index = 1;

us = [u(:,index) u_tilde(:,index)];

% Ps = convert_to_cell([P P_tilde]);

Ps_element =[P P_tilde];

length_cell = length(Ps_element(:)) / 12;

% create Ps as empty two cells
Ps = cell(1, length_cell);

% Get Ps element from the cameras matrix 
for i = 1 : length_cell

    Ps{i} = reshape(Ps_element(12*i-11:12*i), 3, 4);
        
end

U_new = refine_triangulation(Ps, us, Uhat(:,index));


%% 4.11

N = length(Uhat); % number of 3D point


U = zeros(3, N); % create empty matrix to store points

for i = 1 : N
    
    us = [u(:,i) u_tilde(:,i)]; % integrate the points in matrix
    
    U(:,i) = refine_triangulation(Ps, us, Uhat(:,i)); % refine the 3D matrix
    
end

% Plot original 3D points
figure (2)
scatter3(Uhat(1,:), Uhat(2,:), Uhat(3,:), 'k.')
axis equal; axis off
view(2, 2)

% Plot refined 3D points
figure(3)
scatter3(U(1,:), U(2,:), U(3,:), 'k.')
axis equal; axis off
view(2, 1)

%% 4.12 


cam_pos = -P(:, 1:3) \ P(:, 4); % positions
cam_pos_tilde = -P_tilde(:, 1:3) \ P_tilde(:, 4);

dimensions = [U cam_pos cam_pos_tilde]; % Get the 3D dimintion in one matrix

M = length(dimensions); % length of 3D dimention

col_positions = zeros(M, 3); % determine colors for the 3D matrix
col_positions(end-1:end, :) = repmat([1 0 0], 2, 1);

positions_sizes = 10 * ones(M, 1); % determine sizes of the matrix
positions_sizes(end-1:end, :) = [10; 10];

txt = mat2str(cam_pos);
txt_tilde = mat2str(round(cam_pos_tilde(:)*100)/100);

% Plot camera centres and 3D points
figure(4)
scatter3(dimensions(1,:), dimensions(2,:), dimensions(3,:), positions_sizes, col_positions, 'filled'), axis equal
view(8, 8)
text(cam_pos(1)+.1, cam_pos(2), cam_pos(3), txt)
text(cam_pos_tilde(1)+.1, cam_pos_tilde(2), cam_pos_tilde(3), txt_tilde)

%% 4.13 

addpath('sift')
pts = imread('duomo.jpg');
pts_tilde = imread('duomo_tilde.jpg');

duomo_function(pts, pts_tilde)

load 'U_new.mat'
load 'U_colored.mat'


figure()
scatter3(Ur(1,:), Ur(2,:), Ur(3,:), 30, colors, 'filled')
axis equal; axis off
view(0, -80)





%% 4.14

load P.mat
E = essentialMatrix(P1,P2);













