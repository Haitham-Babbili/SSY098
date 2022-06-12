%% LAB 1 - Part 1
% This script gives the solution from Ex 1.1 to Ex 1.12
% This script and all relative functions are tested in MATLAB R2016b
% Author: Qixun Qu

%% Clean Environment
clc
clear
close all

%% A Simple Test -- Ex 1.1 - 1.7
% Generate a simple image to do test
simple_test_img = reshape((11:100), 10, 9);

% Ex 1.1 & 1.2 - Get a patch from test image
test_patch = get_patch(simple_test_img, 5, 5, 3);

% Ex 1.3 - Get a patch from test image, but in this time, the edge of image
% will be exceed and an error appears
% test_patch = get_patch(test_img, 5, 5, 5);

% Ex 1.4 - Filtering the test patch with gaussian filter
test_patch_filt = gaussian_filter(test_patch, 3.0);

% Ex 1.5 - Compute the gradient of test patch in x and y direction
[patch_grad_x, patch_grad_y] = gaussian_gradients(test_patch_filt, 3.0);

% Ex 1.6 - Plot gradients on test patch
% figure
% imagesc(test_patch), colormap gray
% axis image, axis off
% hold on
% quiver(patch_grad_x, patch_grad_y)
% hold off

% Ex 1.7 - Compute the gradient histogram of test patch
histogram = gradient_histogram(patch_grad_x, patch_grad_y);

% Plot gradient histogram
% plot_bouquet(test_patch, 3.0)

%% Generate Gradient Descriptor -- Ex 1.8 - 1.9
% The image set in digits.mat has 100 training images and 50 validation
% images, all images are in grayscale and lack of descriptors
% the scale of each image is 39 x 39
load digits.mat

% Set the index of an image in training set, this image is used in
% next few steps, the range of idx is from 1 to 100
idx = 37;

% Extract the image from training set
train_img = digits_training(idx).image;

% Set the position of the train image's center
% Set the scale of the intrested patch that needs to be processed
% in this case, the entire training image is intrested patch
position = [20, 20];
scale = 39;

% Ex 1.8 - Plot nine squares on training image
plot_object_squares(train_img, [position scale])

% Ex 1.9 - Calculate the descriptor of this training image
desc = gradient_descriptor(train_img, position, scale);

%% Digit Classification -- Ex 1.10 - 1.12
% Ex 1.10 - Compute descriptors for all training images
digits_training_desc = prepare_digits( digits_training );

% Set the index of an image in validation set, this image is used in
% next step, the range of idx is from 1 to 50
idx = 37;

% Ex 1.11 - Validate one digit, get the label for this image and display
% classification result
label = classify_digit(digits_validation(idx).image, digits_training_desc);

fprintf('Validate one digit - the NO.%d validation image\n', idx)
fprintf('The label of validating digit is %d,it should be %d.\n\n', ...
        label, digits_validation(idx).label)

% Ex 1.12 - Validate all digits 
classify_all_digits(digits_validation, digits_training_desc);
