%% Optional Task for Diffusion Tensor Imaging
% Optional task 2 of lab 2 for Diagnostic Imaging.
% Group Members: Qixun Qu, Yankun Xu, Zihui Wang.
% Scripts and functions are tested in Matlab 2017a.
% 2017/06/02

%% Clean Environment
clc; clear; close all

%% Part 1: Calculate FA and PDD
% The known diffusion tensor
D = 10^-4 * [17, 0, 0;
             0,  7, 0;
             0,  0, 4];

% Obtain its FA and PDD
[FA, PDD] = compute_FA_PDD(D);

fprintf(['For known diffusion tensor:\n' ...
         'FA = %.4f\nPDD = [%.4f, %.4f, %.4f]\n\n'], ...
        FA, PDD(1), PDD(2), PDD(3));

%% Part 2 Estimate Diffusion Tensor with Noisy Signal
%% Initialization
b = 1500; S0 = 1000; SNR = 15; var = S0 / SNR;
dir_num = 30; % the number of gradient direction

% Generate gradient direction whose dimension is 3 by dir_num,
% each row vector is an unit vector
g = rand(3, dir_num);
for i = 1 : dir_num
    g(:, i) = g(:, i) / norm(g(:, i));
end

%% Step 2 Do Estimation based on Noisy Signal
% Estimate diffusion tensor and compute its FA and PDD
[D_hat, FA_hat, PDD_hat] = estimate_D_hat(D, g, b, S0, var);

% Angular error
AE = acos(PDD' * PDD_hat);

fprintf(['For estimated diffusion tensor:\n' ...
         'FA = %.4f\nPDD = [%.4f, %.4f, %.4f]\n' ...
         'Angular error = %.4f rad\n\n'], ...
        FA_hat, PDD_hat(1), PDD_hat(2), PDD_hat(3), AE);

%% Step 3 Repeat Step 2 100 Times
% Set the number of iterations
iter_num = 100;

% Obtain mean FA and mean AE
[mean_FA, mean_AE] = multiple_estimate(iter_num, D, PDD, g, b, S0, var);

fprintf(['After %i estimation:\n' ...
         'mean FA = %.4f\nmean AE = %.4f rad\n\n'], ...
        iter_num, mean_FA, mean_AE);

%% Compute Confident Interval for Results in Step 3
% Repeat Step 3 many times, compute mean FA and mean AE for each iteration
iter_ci = 100;
mean_FAs = zeros(iter_ci, 1);
mean_AEs = zeros(iter_ci, 1);
for i = 1 : iter_ci
    [mean_FAs(i), mean_AEs(i)] = ...
        multiple_estimate(iter_num, D, PDD, g, b, S0, var);
end

% Compute 95% confident interval for mean FA and mean AE
mean_FA_ci = compute_CI(mean_FAs);
mean_AE_ci = compute_CI(mean_AEs);

fprintf(['After %i times process which computes mean FA\n' ...
         'and mean AE,95%% confident interval for:\n' ...
         'mean FA: [%.4f, %.4f]\nmean AE: [%.4f, %.4f]\n\n'],...
         iter_ci, mean_FA_ci(1), mean_FA_ci(2), mean_AE_ci(1), mean_AE_ci(2))
