%% Group 45 Lab 3 
clc
clear
close all

%% Ex 3.1
% We have 6 degrees of freedom, with 6 variables to determine, we will 
% then need 6 equations to solve.
%The minimal number of point correspondences, K , required in order to 
%estimate an affine transformation between two images is 3, at least
% 

%%  Ex 3.2

img = read_image('examples/mona.png');
A = [0.88 -0.48; 0.48 0.88];% Transformation parameters co-efficients
t = [100;-100];  % t shifts the transformed points in (x,y) direction
target_size = size(img);
warped = affine_warp(target_size, img, A, t);
figure(1)
imagesc(warped);
axis image;

% Change the values in A and t to see what happens. Swap A for a eye(2,2) to try a pure translation
A1=eye(2,2);
t1 = [10;20];
warped1 = affine_warp(target_size, img, A1, t1);
figure(2)
imagesc(warped1);
axis image;
% A = [0.9 -0.9;0.93 0.2];
% t = [30,-30];
% warped1 = affine_warp(target_size, img, A1, t1);
% figure(2)
% imagesc(warped1);
% axis image;



% With A=eye(2,2), it simply returns an 2-by-2 matrix with ones on the main 
% diagonal and zeros elsewhere. It crops the picture a liitle

%%  Ex 3.3
outlier_rate=0;
%outlier_rate = 0.9;
% Generate a test case as the validation 
[pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate);

% True values are outputted in the workspace
%%  Ex 3.4

K = 3;
pts_size=size(pts,2);
index = randi(pts_size,K,1);
pts_N =pts(:,index);
pts_tilde_N=pts_tilde(:,index);

[A, t] = estimate_affine(pts_N, pts_tilde_N);

%%  Ex 3.5

residual_lgth = residual_lgths(A, t, pts, pts_tilde);


%% Ex 3.6
% Setting outlier rates
%outlier_rate = 0.7;
outlier_rate = 0.8;
%outlier_rate = 0.9;
%outlier_rate = 1.0;
[pts, pts_tilde, A_true, t_true] = affine_test_case(outlier_rate);


%% EX 3.7

threshold=1;
[A,t,inlier] = ransac_fit_affine(pts, pts_tilde, threshold);
display(A);
display(t);
display(inlier);
display(A_true);
display(t_true);

%% EX 3.8 warped = align_images(source, target)

% Load source image and target image from the folder 'example'
img_source = read_image('examples/mona.png');
img_target = read_image('examples/lisa.jpg');

% Compute the warped image using align_images function file
img_warped = align_images(img_source, img_target);

% Merge the target image and warped image together
%img_merged = (0.5)*(img_target + img_warped);
%img_merged = (0.3)*img_target + (0.3)*img_warped;
%img_merged = (0.4)*img_target + (0.4)*img_warped;
img_merged = (0.5)*img_target + (0.5)*img_warped;
%img_merged = (0.6)*img_target + (0.6)*img_warped;
%img_merged = (0.7)*img_target + (0.7)*img_warped;

% plot of the new mixed image
figure(4)
imagesc(img_merged)
axis image; axis off

% Save image into folder

imwrite_function(img_warped, 'monalisa_warped.png')
imwrite_function(img_merged, 'monalisa_merged.png')


%% Ex 3.9 - Use given function switch_plot(warped,target)

% Load the given source image and target image
img_source1 = read_image('examples/vermeer_source.png');
img_target1 = read_image('examples/vermeer_target.png');

% Created warped image
img_warped1 = align_images(img_source1, img_target1);

% Plot of the the warped image
figure(5)
switch_plot(img_target1, img_warped1, 1)

% Save image 
imwrite_function(img_warped1, 'vermeer_warped.png')



%% Ex 3.10 CT Images
% Load the given source image and target image

img_target2 = read_image_grayscale('examples/CT_1.jpg');
img_source2 = read_image_grayscale('examples/CT_2.jpg');


% Created warped image
img_warped2 = align_images(img_source2, img_target2, 10,true);

% Merge the target image and warped image together
%img_merged2 = (0.4)*img_target2 + (0.8)*img_warped2;
img_merged2 = (0.3)*img_target2 + (0.5)*img_warped2;

% Show the merged image 
figure(6)
% switch_plot(warped, img_target);
imagesc(img_merged2), colormap gray
axis image; axis off

% Save image
imwrite_function(img_warped2, 'CT_warped.jpg')
imwrite_function(img_merged2, 'CT_merged.jpg')


%% Ex 3.11 Tissue Microphotograph
img_source3 = read_image('examples/tissue_fluorescent.tif');
img_source3 = 1 - img_source3;

% Load target image
img_target3 = read_image('examples/tissue_brightfield.tif');

img_warped3 = align_images(img_source3, img_target3);

img_merged3 = (0.3)*img_target3 + (0.7)*img_warped3;

figure(7)
switch_plot(img_target3, img_source3)
imagesc(img_merged3)
axis image; axis off

% Save image
imwrite_function(img_warped3, 'tissue_warped.tif')
imwrite_function(img_merged3, 'tissue_merged.tif')

%% Ex 3.12 value = sample_image_at(img, position)

img = read_image_grayscale('examples/source_16x16.tif');
position = [3,5];
value = sample_image_at(img, position);




%% Ex 3.13
% Warp the given image
%img = read_image_grayscale('examples/source_16x16.tif');
img_warped4 = warp_16x16(img);

% Plot both source image and warped image
figure(8)
imagesc(img)
axis image; axis off

figure(9)
imagesc(img_warped4)
axis image; axis off


%% Ex 3.14

source = read_image('examples/vermeer_source.png');
target = read_image('examples/vermeer_target.png');

threshold = 1;
upright = false;

% Created warped image
warped = align_images(source, target, threshold, upright);


% Plot of the the warped image
figure(10)
switch_plot(img_target1, img_warped1, 1)

% Save image 
imwrite_function(img_warped1, 'vermeer_warped_Ex3.14.png')


