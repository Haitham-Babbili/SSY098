% Lab4 Cammera Geometric

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

%% 4.4function [U, nbr_inliers] = ransac_triangulation(Ps, us, threshold)

%% 4.5

triangulate_sequence(Ps, us)

%load 
load 'U.mat'
load 'nbr_inliers'

U = U(:, nbr_inliers >= 2);

% Clean up the data 
Uc = clean_for_plot(U);

% Plot triangulated points
% It is Arc de Triomphe in the plot
figure (1)
scatter3(Uc(1,:), Uc(2,:), Uc(3,:), 'k.')
axis equal; axis off
view(-172, 4)


%% 4.6 
% the answer in pdf file
%%  4.7  all_residuals = compute_residuals(Ps, us, U);

%% 4.8 - Jacobian Matrix
% Generate the formula of Jacobian matrix
% the answer in pdf file

%% 4.9 jacobian = compute_jacobian(Ps, U);

%% 4.10 

load 'gauss_newton.mat'

idx = 1;

us = [u(:,idx) u_tilde(:,idx)];

% Ps = convert_to_cell([P P_tilde]);

Ps_element =[P P_tilde];

length_cell = length(Ps_element(:)) / 12;

% cresat Ps as empty tow cell
Ps = cell(1, length_cell);

% Get Ps element from the cameras matrix 
for i = 1 : length_cell

    Ps{i} = reshape(Ps_element(12*i-11:12*i), 3, 4);
        
end

U_new = refine_triangulation(Ps, us, Uhat(:,idx));


%% 4.11

N = length(Uhat); % number or 3D point


U = zeros(3, N); % creat empty matrix for storeg

for i = 1 : N
    
    us = [u(:,i) u_tilde(:,i)]; % integrate the points in matrix
    
    U(:,i) = refine_triangulation(Ps, us, Uhat(:,i)); % fell the 3D matrix
    
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

% we can get camera position c_p = -P(:,1:3) \ P(:,4)
% where P = [first_coluomn | last_column]

c_p = -P(:, 1:3) \ P(:, 4);
c_p_tilde = -P_tilde(:, 1:3) \ P_tilde(:, 4);

dimintions = [U c_p c_p_tilde]; % Get the 3D dimintion in one matrix

M = length(dimintions); % length of 3D dimention

col_positions = zeros(M, 3); % determin colors for the 3D matrix
col_positions(end-1:end, :) = repmat([1 0 0], 2, 1);

positions_sizes = 10 * ones(M, 1); % determin sizes of the matrix
positions_sizes(end-1:end, :) = [10; 10];

txt = mat2str(c_p);
txt_tilde = mat2str(round(c_p_tilde(:)*100)/100);

% Plot camera centers and 3D points
figure(4)
scatter3(dimintions(1,:), dimintions(2,:), dimintions(3,:), positions_sizes, col_positions, 'filled'), axis equal
view(8, 8)
text(c_p(1)+.1, c_p(2), c_p(3), txt)
text(c_p_tilde(1)+.1, c_p_tilde(2), c_p_tilde(3), txt_tilde)

%% 4.13 

addpath('sift')
pts = imread('duomo.jpg');
pts_tilda = imread('duomo_tilde.jpg');

dom_triangular(pts, pts_tilda)



load 'U_new.mat'
load 'U_colored.mat'

% Find indices for points who has at least 2 inliers
U_new = U_new(:, U_colored >= 2);

% Clean refined points, remove some points with
% rather high and rather low values
Ur = clean_for_plot(U_new);

% Plot points with colors
figure(5)
scatter3(Ur(1,:), Ur(2,:), Ur(3,:), 20, col_positions, 'filled')
axis equal; axis off
view(0, -80)

%% 4.14

load P.mat
E = essentialMatrix(P1,P2);













