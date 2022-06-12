%% A Demo for ART-Tools
% Optional task 2 of lab 3 for Diagnostic Imaging.
% Group Members: Qixun Qu, Yankun Xu, Zihui Wang.
% Scripts and functions are tested in Matlab 2017a.
% 2017/05/24

%% Clean Environment
clc; clear; close all

%% Load Source Image
sq = im2double(imread('sq.png'));

%% Create Test Problem
% Set the parameters for the test problem
N = max(size(sq));       % The discretization points
theta = 0:179;           % Number of used angles
p = round(sqrt(2) * N);  % Number of parallel rays

% Create the test problem
[A, b] = paralleltomo(N, theta, p, sq);

% A modification was done in the function paralleltomo.
% A new test case (sq, the given image) was input into the function,
% instead of generating the case from a built-in phantom in the function.

%% Add Noise
% Relative noise level
eta = 0;
% Noise level
delta = eta * norm(b);
% Add noise to the rhs
randn('state',0);
e = randn(size(b));
e = delta * e / norm(e);
b = b + e;

%% Perform Iteration
% Number of iterations
k = 20;
% Perform the kaczmarz iterations
sq_kacz = reshape(kaczmarz(A, b, k), N, N);

%% Plot Results
% Show the original object
figure
imagesc(sq), colormap gray
axis image off
% Show the kaczmarz solution
figure
imagesc(sq_kacz), colormap gray
axis image off