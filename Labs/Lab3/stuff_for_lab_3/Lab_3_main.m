clc
clear
close all

%% 3.1

% minim number of k is 3 

%% 3.2

img = read_image('examples/mona.png');
A_N = [0.88 -0.48; 0.48 0.88];
% A = [0.55 0.83; 0.76 0.70]; % coafition of transformation parameter
% A=eye(2,2)
t_N = [100;-100];  % targetr cordinates
% t = [50;-20]; 
target_size = size(img);
warped = affine_warp(target_size, img, A_N, t_N);
imagesc(warped);
axis image;

%% 3.3
outlier_rate=0.8;
[pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate);

%% 3.4

K = 3;
max_point= 50;
index = randperm(max_point,K);
pts_N =pts(:,index);
pts_tilde_N=pts_tilde(:,index);

[A_N, t_N] = estimate_affine(pts_N, pts_tilde_N);

%% 3.5

residual_lgth = residual_lgths(A_N, t_N, pts, pts_tilde);


%% 3.6

outlier_rate=0.8;
[pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate);


%% 3.7

threshold=1;
[A,t] = ransac_fit_affine(pts, pts_tilde, threshold);

%% 3.8 warped = align_images(source, target)

img_source = read_image_grayscale('examples/vermeer_source.png');
img_target = read_image_grayscale('examples/vermeer_target.png');

warped = align_images(img_source, img_target);
%% 3.9

switch_plot(warped, img_target);

%% 3.10

img_source = read_image_grayscale('examples/CT_1.jpg');
img_target = read_image_grayscale('examples/CT_2.jpg');

upright = true;
threshold = 1;

warped = align_images_mod(img_source, img_target, threshold, upright);

switch_plot(warped, img_target);

%% 3.11


img_source = read_image_grayscale('examples/tissue_fluorescent.tif');
img_target = read_image_grayscale('examples/tissue_brightfield.tif');

img_target=1-img_target;

upright = false;
threshold = 1;

warped = align_images_mod(img_source, img_target, threshold, upright);

switch_plot(warped, img_target);

%% 3.12 value = sample_image_at(img, position)

img = read_image_grayscale('examples/source_16x16.tif');
position = [3,5];
value = sample_image_at(img, position);

%% 3.13
img = read_image_grayscale('examples/source_16x16.tif');
warped = warp_16x16(img);

imagesc(warped);

%% 3.14
source = read_image_grayscale('examples/vermeer_source.png');
target = read_image_grayscale('examples/vermeer_target.png');

threshold = 1;
upright = false;

warped = align_images_mod(source, target, threshold, upright);

switch_plot(warped, target);



