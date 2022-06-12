%% LAB 1 - Part 2
% This script gives the solution of Ex 1.13
% This script and all relative functions are tested in MATLAB R2016b

%% Clean Environment
clc
clear
close all

%% Find Digits in Image
% Read image
img = imread('paper_with_digits.png');
img = im2double(img);

% Remove image background
[img_bt, img_bw] = remove_background(img);

% Get objects in image automaticlly
[obj_pos, obj_num] = get_objects(img_bw);

% Plot 9-squares on each digit
plot_object_squares(img, obj_pos)

%% Struct Test Set
% The struct consists of the position and the scale of each digit
% as well as the real label for each digit 
real_labels = [9 3 4 5 1 9 4 7 5 6 2 8 3];
my_test = struct_testset(obj_pos, obj_num, real_labels);

%% Classify Digits in Image
classify_img_digits(img_bt, my_test, obj_num, real_labels)
