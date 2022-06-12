%% Lab2 -- Part 2 -  Deep Learning
% This script gives the solution from Ex 2.9 to Ex 2.20
% This script and all relative functions are tested in MATLAB R2016b
% in 64-bit Windows 7
% Author: Qixun Qu

%% Clean Environment
clc
clear
close all

%% Setup MatConvNet - Ex - 2.11
run matconvnet-1.0-beta23\matlab\vl_setupnn.m

%% Load Data - Ex 2.12
% Load training set and validation set
load characters_train.mat
load characters_val.mat

%% Build the Given Network - Ex 2.13
net = build_network;

%% Normalize Data - Ex 2.14
% Normalize training data
data_train_norm = preprocess_data(data_train);

% Normalize validation data
data_val_norm = preprocess_data(data_val);

%% Build the Model - Ex 2.15 - 2.16
net = cnn_train_mod(net, data_train_norm, data_val_norm, ...
                    @random_subset, 'chars/', 5);
                
%% Run Network on Testset - Ex 2.18
% Load test data
load characters_test.mat

% Preprocess test data
data_test_norm = preprocess_data(data_test);

% Predict labels for testset by the built model
predicted_labels = cnn_predict(net, data_test_norm.imgs);

% Calculate recall and precision of predicted results
recall = compute_recall(predicted_labels, data_test.labels);
precision = compute_precision(predicted_labels, data_test.labels);

% Save recall and precision into txt file
save_to_file('Results\given_net_results.txt', recall, precision)

%% Save Three Failure Cases - Ex 2.19
save_mistake_img(predicted_labels, data_test)

%% Build My Netword and Predict Testset - Ex 2.20
% Build my network
my_net = build_my_network();

% Build my model for predicting
my_net = cnn_train_mod(my_net, data_train_norm, data_val_norm, ...
                       @random_subset, 'my_chars/', 5);
                   
% Predict labels for testset by my model
my_predicted_labels = cnn_predict(my_net, data_test_norm.imgs);

% Calculate recall and precision of predicted results
recall = compute_recall(my_predicted_labels, data_test.labels);
precision = compute_precision(my_predicted_labels, data_test.labels);

% Save recall and precision into txt file
save_to_file('Results\my_net_results.txt', recall, precision)