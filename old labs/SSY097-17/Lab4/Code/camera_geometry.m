%% Lab 4 - Camera Geometry
% This script gives the solution from Ex 4.1 to Ex 4.13
% This script and all relative functions are tested in MATLAB R2016b

%% Clean Environment
clc
clear
close all

%% Ex 4.1 - Minimal Solver
% Generate a test case of triangulation
sigma = 0;
[Ps, us, U_true] = triangulation_test_case(sigma);

% Run the minimal solver to obtain triangulated 3D points
U = minimal_triangulation(Ps, us);

% Display the true points and triangulated ponts,
% they are same when sigma equals to 0
display(U_true)
display(U)

%% Ex 4.2 - Check Depths
% Check the sign of depts
positive = check_depths(Ps, U);
display(positive)

%% Ex 4.3 - Compute Reprojection Errors
% Calculate the errors between known image points
% and reprojected points
errors = reprojection_errors(Ps, us, U);
display(errors)

%% Ex 4.4 & 4.5 - Run RANSAC
% Ex 4.4 and 4.5 are implemented in script file
% triangulate_sequence.m, wanted outputs are saved in
% Us.mat and nbr_inliers.mat in folder 'data'

% Load the outputs
load 'data/Us.mat'
load 'data/nbr_inliers.mat'

% Get the triangulated points which has
% two inliers at least
Us = Us(:, nbr_inliers >= 2);

% Clean the data
Uc = clean_for_plot(Us);

% Plot triangulated points
% It is Arc de Triomphe in the plot
figure
scatter3(Uc(1,:), Uc(2,:), Uc(3,:), 'k.')
axis equal; axis off
view(-170, 5)

%% Ex 4.6 - Formula for the Reprojection Error
% The residual vector between reprojected points and
% known points under a given camera matrix and a 3D point
%
% U  = [X Y Z 1]'       |<-- ai -->|   | ai1 ai2 ai3 ai4 |
% ui = | xi |      Pi = |<-- bi -->| = | bi1 bi2 bi3 bi4 |
%      | yi |           |<-- ci -->|   | ci1 ci2 ci3 ci4 |
%
% ri[U] = | (ai*U) / (ci*U) | - | xi |
%         | (bi*U) / (ci*U) |   | yi |

%% Ex 4.7 - Comput Residuals Vector
% Comput the residuals vector between reprojected points
% and known image points
% all_residuals = compute_residuals(Ps, us, U);

%% Ex 4.8 - Jacobian Matrix
% Generate the formula of Jacobian matrix
%
%     | dr[1,x]/dX  dr[1,x]/dY  dr[1,x]/dZ |
%     | dr[1,y]/dX  dr[1,y]/dY  dr[1,y]/dZ |
% J = |      :           :           :     |
%     | dr[n,x]/dX  dr[n,x]/dY  dr[n,x]/dZ |
%     | dr[n,y]/dX  dr[n,y]/dY  dr[n,y]/dZ |
%
% A Simple case: u = u(x) v = v(x)
% d(u/v) / dx = ( du/dx * v - u * dv/dx ) / v^2
%
% dr[i,x] / dX = ( ai1*ci*U - ci1*ai*U ) / ( ci*U )^2
% dr[i,x] / dY = ( ai2*ci*U - ci2*ai*U ) / ( ci*U )^2
% dr[i,x] / dZ = ( ai3*ci*U - ci3*ai*U ) / ( ci*U )^2
%
% dr[i,y] / dX = ( bi1*ci*U - ci1*bi*U ) / ( ci*U )^2
% dr[i,y] / dY = ( bi2*ci*U - ci2*bi*U ) / ( ci*U )^2
% dr[i,y] / dZ = ( bi3*ci*U - ci3*bi*U ) / ( ci*U )^2

%% Ex 4.9 - Compute Jacobin Matrix
% Compute the Jacobian matrix of the partial derivatives
% of residual vectors
% jacobian = compute_jacobian(Ps, U);

%% Ex 4.10 - Refine Triangulation by Gauss-Newton Method
% Load data
load 'data/gauss_newton.mat'

% Extract one example tp test the refine function
idx = 1;

% Combine two image points into one matrix
us = [u(:,idx) u_tilde(:,idx)];

% Combine two camera matrix into one cell
Ps = convert_to_cell([P P_tilde]);

% Carry out the refine process
U_rf = refine_triangulation(Ps, us, Uhat(:,idx));

%% Ex 4.11 - Refine the Given Data
% All given 3D points will be refined in this section
% by Gauss-Newton method

% Obtain the number of 3D points
pts_num = size(Uhat, 2);

% Initialize the matrix to store refine points
U = zeros(3, pts_num);

% Combine two camera matrix into one cell
% Ps has been generated in last section
% Ps = convert_to_cell([P P_tilde]);

for i = 1 : pts_num
    
    % Combine two image points into one matrix
    us = [u(:,i) u_tilde(:,i)];
    
    % Refine the ith 3D point
    U(:,i) = refine_triangulation(Ps, us, Uhat(:,i));
    
end

% Plot original 3D points
figure
scatter3(Uhat(1,:), Uhat(2,:), Uhat(3,:), 'k.')
axis equal; axis off
view(0, 0)

% Plot refined 3D points
figure
scatter3(U(1,:), U(2,:), U(3,:), 'k.')
axis equal; axis off
view(0, 0)

%% Ex4.12 - Camera Position
% Calculate the camera position C
% According to the equation P = [KR | -KRC],
% where KR is the first three columns in P,
% -KRC is the last column in P
% C can be calculated as C = -P(:,1:3) \ P(:,4)
C = -P(:, 1:3) \ P(:, 4);
C_tilde = -P_tilde(:, 1:3) \ P_tilde(:, 4);

% Put two camera positions into the matrix of
% 3D points' positions
U_and_C = [U C C_tilde];

% Define two different colors for 3D points and camera centers
colors = zeros(size(U_and_C, 2), 3);
colors(end-1:end, :) = repmat([1 0 0], 2, 1);

% Define two different sizes for 3D points and camera centers
sizes = 10 * ones(size(U_and_C, 2), 1);
sizes(end-1:end, :) = [30; 30];

% Generate the text of positions for two camera centers
txt = mat2str(C);
txt_tilde = mat2str(round(C_tilde(:)*100)/100);

% Plot camera centers and 3D points
figure
scatter3(U_and_C(1,:), U_and_C(2,:), U_and_C(3,:), ...
         sizes, colors, 'filled'), axis equal
view(10, 10)
text(C(1)+.1, C(2), C(3), txt)
text(C_tilde(1)+.1, C_tilde(2), C_tilde(3), txt_tilde)

%% Ex 4.13 - Triangulate Duomo
% Ex 4.13 are implemented in script file
% triangulate_duomo.m, wanted outputs are saved in
% Ur.mat and colors.mat in folder 'data'

% Load outputs
% Ur.mat has refined triangulated 3D points
% colors.mat provides the color extracted 
% from original image for each point
load 'data/Ur.mat'
load 'data/colors.mat'

% Plot points with colors
figure
scatter3(Ur(1,:), Ur(2,:), Ur(3,:), 20, colors, 'filled')
axis equal; axis off
view(0, -90)
