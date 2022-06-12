%% Diffusion Signal Curve Fitting
% Task 4 of lab 2 for Diagnostic Imaging.
% Group Members: Qixun Qu, Yankun Xu, Zihui Wang.
% Scripts and functions are tested in Matlab 2017a.
% 2017/05/15

%% Clean Environment
clc; clear; close all

%% Load Data
load ChalmersFittingExcerciseR1.mat
% Curve points are stored in variable 'data'
% Column:    1         2         3        4
%         b-factor  S Normal  S Tumor  S Noise

% Extract data
len = size(data, 1);
b = data(:, 1);
SNormal = data(:, 2);
STumor = data(:, 3);
SNoise = data(:, 4);

%% Problem 1
% How do you deal with outliers?
% Replace the outlier with the mean of
% two neighboring numbers of the outlier.

% Show the original data and the data removed outlier
figure
plot(b, SNormal, '-o', 'LineWidth', 1.2, 'MarkerSize', 8), grid on
hold on

% Replase the outlier with the mean
SNormal(14) = mean((13) + SNormal(15));

plot(b, SNormal, '-o', 'LineWidth', 1.2, 'MarkerSize', 4, 'MarkerFaceColor', 'r')
set(gca, 'FontSize', 12)
xlabel('b-factor (s/{mm^2})')
ylabel('S Normal')
legend('Original Data', 'Data without Outlier')

%% Problem 2
% Perform least-square fit (b-factors < 1000, i.e. 5 data)
idx = find(b < 1000);
[logSN0, DN] = least_square_fit(b(idx), SNormal(idx));
[logST0, DT] = least_square_fit(b(idx), STumor(idx));

% Logarithmic results
SNormal_log_inv = logSN0 - b * DN;
STumor_log_inv = logST0 - b * DT;

% Monoexponential results
SNormal_inv = exp(SNormal_log_inv);
STumor_inv = exp(STumor_log_inv);

%% Problem 3
% Perform non-linear fit (b-factors < 1000, i.e. 5 data)
fun = @(x, xdata)x(1) * exp(-xdata * x(2));
xN0 = [0, 0];
xT0 = [0, 0];

% Non-linear fit of SNormal
[xN, resN] = lsqcurvefit(fun, xN0, b(idx), SNormal(idx));
SNormal_inv_nl = xN(1) * exp(-b * xN(2));

% Non-linear fit of STumor
[xT, resT] = lsqcurvefit(fun, xT0, b(idx), STumor(idx));
STumor_inv_nl = xT(1) * exp(-b * xT(2));

%% Problem 5
% Perform non-linear fit (all b-factors)
% Non-linear fit of SNormal
xNA = lsqcurvefit(fun, xN0, b, SNormal);
SNormal_inv_nla = xNA(1) * exp(-b * xNA(2));

% Non-linear fit of STumor
xTA = lsqcurvefit(fun, xT0, b, STumor);
STumor_inv_nla = xTA(1) * exp(-b * xTA(2));

%% Problem 4
% Plot all fitting results

% Monoexponential SNormal
SNormal_cell = {SNormal, SNormal_inv, ...
                SNormal_inv_nl, SNormal_inv_nla};
% Monoexponential STumor
STumor_cell = {STumor, STumor_inv, ...
               STumor_inv_nl, STumor_inv_nla};

% Logarithmic SNormal
SNormal_log_cell = {log(SNormal), SNormal_log_inv, ...
                    log(SNormal_inv_nl), log(SNormal_inv_nla)};
STumor_log_cell = {log(STumor), STumor_log_inv, ...
                   log(STumor_inv_nl), log(STumor_inv_nla)};
% Logarithmic STumor
plot_fit(b, SNormal_cell, 'S Normal')
plot_fit(b, STumor_cell, 'S Tumor')

% Plot results
plot_fit(b, SNormal_log_cell, 'S Normal (log)')
plot_fit(b, STumor_log_cell, 'S Tumor (log)')