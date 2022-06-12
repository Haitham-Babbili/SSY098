%% Lab3 - Image Registration
% This script gives the solution from Ex 3.1 to Ex 3.14
% This script and all relative functions are tested in MATLAB R2016b

%% Clean Environment
clc
clear
close all

%% Preparation
% If the folder 'results' is not exist, create the folder
% All warped and fusion images will be saved in this folder
if ~exist('results', 'dir')
   mkdir('results')
end

%% Ex 3.1 - Minimum Number of Point Correspondences
% To estimate an affine transformation between two images,
% at least 3 corresponding points are needed.
% In this lab, 6-parameter affine transformation are taken into
% consideration, which is shown as follows:
%        | x' | = | a b | * | x | + | tx |
%        | y' |   | c d |   | y |   | ty |
% For 3 corresponding points, 6 equations can be formed as below:
%        | x1 y1 0  0  1 0 |       | a  |       | x1' |
%        | 0  0  x1 y1 0 1 |       | b  |       | y1' |
%        | x2 y2 0  0  1 0 |   *   | c  |   =   | x2' |
%        | 0  0  x2 y2 0 1 |       | d  |       | y2' |
%        | x3 y3 0  0  1 0 |       | tx |       | x3' |
%        | 0  0  x3 y3 0 1 |       | ty |       | y3' |
%        |------> M <------|   |-> theta <-|   |-> b <-|
% Solve the equation to compute theta by:  theta = M \ b
% Thus, affine transformation can be obtained as:
%        A = | a b |     t = | tx |
%            | c d |         | ty |

%% Ex 3.2 - A Simple Trying
% Read source image
img = read_image('examples/mona.png');

% Apply simple transformation on the input image,
% including rotation, scaling and translation
try_simple_transform( img )

%% Ex 3.3 & 3.6 - Generate A Test Case
% Setting outlier rate
outlier_rate = 0.9;
% Generate a test case as the validation 
[pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate);

%% Ex 3.4 - Affine Transformation Estimation
K = 3;
idx = randi(size(pts, 2), K, 1);
[A_test, t_test] = estimate_affine(pts(:, idx), pts_tilde(:, idx));

%% Ex 3.5 - Compute the Length of 2D Residual Vectors
residual_lengths = residual_lgths(A_test, t_test, pts, pts_tilde);

%% Ex 3.7 - Run RANSAC to Find Affine Transformation
threshold = 1;
[A_rsc, t_rsc, ~] = ransac_fit_affine(pts, pts_tilde, threshold);

display(A_true); display(A_rsc)
display(t_true); display(t_rsc)

%% Ex 3.8 - Apply SIFT and RANSAC to Warp Image
% Load source image and target image
img_source = read_image('examples/mona.png');
img_target = read_image('examples/lisa.jpg');

% Comput the warped image
img_warped = align_images(img_source, img_target);

% Merging the target image and warped image toghter
img_mixed = 0.5*img_target + 0.5*img_warped;

% Show the mixed image
figure
imagesc(img_mixed)
axis image; axis off

% Save image into 'results' folder
save_image(img_warped, 'results/monalisa_warped.png')
save_image(img_mixed, 'results/monalisa_mixed.png')

%% Ex 3.9 - Example of Vermeer
% Load source image and target image
img_source = read_image('examples/vermeer_source.png');
img_target = read_image('examples/vermeer_target.png');

% Comput the warped image
img_warped = align_images(img_source, img_target);

% Show the warped image
figure
switch_plot(img_target, img_warped, 1)

% Save image into 'results' folder
save_image(img_warped, 'results/vermeer_warped.png')

%% Ex 3.10 - Example of CT Images
% Load source image and target image
img_source = read_image('examples/CT_2.jpg');
img_target = read_image('examples/CT_1.jpg');

% Comput the warped image
img_warped = align_images(img_source, img_target, 10,true);

% Merging the target image and warped image toghter
img_mixed = 0.3*img_target + 0.7*img_warped;

% Show the mixed image
figure
imagesc(img_mixed), colormap gray
axis image; axis off

% Save image into 'results' folder
save_image(img_warped, 'results/CT_warped.jpg')
save_image(img_mixed, 'results/CT_mixed.jpg')

%% Ex 3.11 - Example of Tissue Microphotograph
% Load source image and invert its intensity
img_source = read_image('examples/tissue_fluorescent.tif');
img_source = 1 - img_source;

% Load target image
img_target = read_image('examples/tissue_brightfield.tif');

% Comput the warped image
img_warped = align_images(img_source, img_target);

% Merging the target image and warped image toghter
% img_mixed = 0.3*img_target + 0.7*img_warped;

% Show the mixed image
figure
switch_plot(img_target, img_source)
% imagesc(img_mixed)
axis image; axis off

% Save image into 'results' folder
save_image(img_warped, 'results/tissue_warped.tif')
save_image(img_mixed, 'results/tissue_mixed.tif')

%% Ex 3.12 & 3.13 - Warping
% Load samll image
img = read_image('examples/source_16x16.tif');

% Warp the samll image
img_warped = warp_16x16(img);

% Plot souece image and warped image
figure
subplot(1, 2, 1)
imagesc(img), colormap gray
axis image; axis off
subplot(1, 2, 2)
imagesc(img_warped), colormap gray
axis image; axis off

% Save warped image into 'results' folder
save_image(img_warped, 'results/warped_16x16.tif')

%% Ex 3.14 - Least Squares
% [A, t] = least_squares_affine(pts, pts_tilde);
% In fact, the function least_squares_affine() is exactly same as
% the function estimate_affine().