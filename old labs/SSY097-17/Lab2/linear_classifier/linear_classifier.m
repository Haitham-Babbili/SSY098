%% Lab2 -- Part 1 - Learning A Linear Classier
% This script gives the solution from Ex 2.1 to Ex 2.8
% This script and all relative functions are tested in MATLAB R2016b
% in 64-bit Windows 7

%% Clean Environment
clc
clear
close all

%% Preparing the Data -- Ex 2.1 - 2.2
% Ex 2.1 - Load data
load traffic_data.mat

% Ex 2.2 - Plot several positive and negative examples
% plot_examples(examples, labels)

%% Training the Classifier -- Ex 2.3 - 2.5
% Initialize two parameters, w0 is a number,
% w is a matrix, its size is same as training example
w0 = 0;
w = 0.01 * randn(35, 35, 3);

% Run 5 epochs
for i = 1 : 5
    
    % Update parameters in each epoch
    [w, w0] = process_epoch(w, w0, examples, labels);
    
end

% Plot w
% wp = w - min(w(:));
% wp = wp / max(wp(:));

figure
imagesc(w), axis off

%% Sliding Window -- Ex 2.6 - 2.7
% Read an test image
img = imread('traffic_test/img_4.png');
% Convert image values to the range of 0-1
img = im2double(img);

% Applies linear classifier at every point in test image
% to get the probability of each point
prob = sliding_window(img, w, w0);

% Plot result of previous step, points that have high
% probability will be marked in yellow
figure
view_with_overlay(img, prob > 0.5)

%% Extract Local Maxima -- Ex 2.8
% Extract positions of all local maxima
[max_rows, max_cols] = strict_local_maxima(prob);

% Plot result on test image
figure
imagesc(img), colormap gray
axis image, axis off
hold on
plot(max_cols, max_rows, 'r*')
hold off
