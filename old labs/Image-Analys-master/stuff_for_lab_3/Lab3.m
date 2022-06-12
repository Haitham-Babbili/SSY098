%% Lab3

%% 3.1

%the minimal number of point correspondences,K , required in order to 
%estimate an affine transformation between two images is 3 at least

%% 3.2

img = read_image('examples/mona.png');
A =[2 0; 0 -2];  %eye(2,2); %[0.88 -0.48; 0.48 0.88];
t = [-200;-800];%[300;-300];
target_size = size(img);
warped = affine_warp(target_size, img, A, t);
imagesc(warped);
axis image;

%% 3.3

% create function [pts, pts_tilde, A_true, t_true] = affine_test_case
% see affine_test_case.m
tot_pts = 100;
[pts, pts_tilde, A_true, t_true] = affine_test_case(0, tot_pts)


%% 3.4

% create function [A, t] = estimate_affine(pts, pts_tilde)
% see estimate_affine.m
numberofponts = 3;
num = randperm(tot_pts,numberofponts);
pts1 =pts(:,num);
pts_tilde1=pts_tilde(:,num);

[A, t] = estimate_affine(pts1, pts_tilde1)

%% 3.5

%create function residual_lgths = residual_lgths(A, t, pts, pts_tilde),
%see residual_lgths.m

residual_lengths = residual_lgths(A, t, pts1, pts_tilde)



%% 3.6

% uppdate affine_test_case to take outlaier_rate
% see affine_test_case.m
tot_pts = 100;
[pts, pts_tilde, A_true, t_true] = affine_test_case(0.1, tot_pts)

%% 3.7

%create a function [A,t] = ransac_fit_affine(pts, pts_tilde, threshold)
%see ransac_fit_affine.m
[A,t] = ransac_fit_affine(pts, pts_tilde, 0.000000000001)

%% 3.8
source = read_as_grayscale('vermeer_source.png');
target = read_as_grayscale('vermeer_target.png');
%%

warped = align_images(source, target, 0, false);
%% 3.9
switch_plot(warped, target)

%% 3.10
source = read_as_grayscale('CT_1.jpg');
target = read_as_grayscale('CT_2.jpg');
%%
upright = true;
threshold = 5;

warped = align_images(source, target, threshold, upright);

switch_plot(warped, target)

%% 3.11 

target = read_as_grayscale('tissue_fluorescent.tif');
source = read_as_grayscale('tissue_brightfield.tif');

target = 1 - target;
%%
warped = align_images(source, target, threshold, false);
switch_plot(warped, target)

%% 3.12

img = read_as_grayscale('source_16x16.tif');
position = [3,5];
value = sample_image_at(img, position)

%% 3.13

warped = warp_16x16(img);

imagesc(warped)

%% 3.14
source = read_as_grayscale('examples/vermeer_source.png');
target = read_as_grayscale('examples/vermeer_target.png');
%%

threshold = 1;
upright = false;

warped = align_images(source, target, threshold, upright);

switch_plot(warped, target);




