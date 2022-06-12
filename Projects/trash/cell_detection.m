%% Mini Project - Counting Cells by CNN
% The project aims to detect cells in given image.
% All code of this project is tested in RedHat 6.6 and Matlab R2015b.
% You may just run the last section, be sure that add all files of this
% project into the working path.
% Author: Qixun Qu

%% Clean Environment
clc
clear
close all

%% Setup Working Path and MatConvNet
warning('off')
addpath(genpath(pwd))
% Compiled in RedHat 6.6
run cnn/matconvnet-1.0-beta23/matlab/vl_setupnn.m

%% Basic Settings
% Set folders for training set and validation set
folder_train = 'dataset/TrainingSet/';
folder_validate = 'dataset/ValidationSet/';
folder_test = 'dataset/TestingSet/';

% Patch size
pch_size = 35;

% Rotation angles for data augmentation
% all angles = 0 : angle : 180
% if angle > 180, original patch will not be rotated
angle  = 60;

% Color-modified patch for data augmentation
% 2 more images will be generated from each patrch
colors = 2;

% Cell centre radius
% if radius = 0, only the centre points are marked
radius = 0;

% The distance between cell centre to its edge
% The region between centre and edge will not extract
% either positive examples or negative examples
edge = 5;

%-------------------------------- NOTE ----------------------------------% 
% Under this setting, 321,985 examples are generated in training set, 
% 116,338 examples are produced in validation set.
% It will take up large resource of memory.
%------------------------------------------------------------------------%

%% Generate Dataset
% Training set generated from 30 images
data_train = generate_data(folder_train, pch_size, angle, colors, ...
                           radius, edge);

% Validating set generated from 10 images
data_validate = generate_data(folder_validate, pch_size, angle, colors, ...
                              radius, edge);

%% Normalize Data
% Normalize training data
data_train_norm = preprocess_data(data_train);
clear data_train

% Normalize validation data
data_val_norm = preprocess_data(data_validate);
clear data_validate

%% Build the Model
% Build the network and train it with training set
% and validation set
net = build_network;
net = cnn_train_mod(net, data_train_norm, data_val_norm, ...
                    @random_subset, 'cell_net/', 5);

% Save the net into file
save('cell_net.mat', 'net')

clear data_train_norm data_val_norm
                
%% Test the Model
% Use validation set to test model
% [~, images] = read_data( folder_validate );

% Use testing set to test model
[~, images] = read_data( folder_test );

% Select one image and obtain the result
idx = 1;
detection = run_detector(images{idx});

%% Test the Model by Your Image
% You can load an image and put it into the function as
% detection = run_detector(img);
