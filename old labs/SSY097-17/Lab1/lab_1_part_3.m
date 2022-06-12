%% LAB 1 - Part 3
% This script gives the solution from Ex 1.14 to Ex 1.16
% This script and all relative functions are tested in MATLAB R2016b
% NOTE : 
% Add the folder 'shift' and 'church_test' to working path of MATLAB
% before run this script.

%% Clean Environment
clc
clear
close all

%% Load Data
% church_data.mat consists of 18578 descriptors, as well as labels ans
% names for all descriptors
load church_data.mat

% manual_labels.mat consists of the name of each test image
load church_test/manual_labels.mat

%% Using the SIFT Code from vlfeat -- Ex 1.14 - 1.16
% Set the amount of test images, and initialize a vector to
% record the classification result for each test image
imgs_num = 10;
results = zeros(imgs_num, 1);

for i = 1 : imgs_num
    
    fprintf('Start processing No.%d image\n', i)
    
    % Read image in folder, convert the image to grayscale
    img = imread(['church_test/church' int2str(i) '.jpg']);
    img = im2double(img);
    img = rgb2gray(img);
    
    % Classify the church image and obtain the label and name for
    % each image
    [label, name] = classify_church( img, feature_collection );
    
    % Compare classification result with the real label
    % results(i) would be 1 if the classification is right,
    % otherwise, it would be 0
    results(i) = strcmp(name{1}, manual_labels{i});
    
    fprintf('The name of No.%d image is - %s,\nit should be - %s.\n\n',...
            i, name{1}, manual_labels{i})
    
end

% Calculate the number of correct identification of church and
% comput the classification accuracy
correct_num = length(find(results == 1));
accuracy = correct_num / imgs_num;

fprintf(['%d churches are recognized correctly, %d images in total.\n'...
         'Accuracy is %.2f%%.\n\n'],...
        correct_num, imgs_num, accuracy * 100)