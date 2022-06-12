%% Bonus Assignment 2
% By Qixun Qu
% 2017/02/14
% Bonus Assignment 2 of
% Statistic Inference

%% Clean Environment
clc
clear
close all

%% Load Data
load 'whales.mat'

%% Problem A - Histogram
figure
histogram(whales, 20), grid on
set(gca, 'FontSize', 12)
xlabel('Time (in hours) to swim 1 km')

%% Problem B - Method of Moments
% Estimate parameters by the method of moments
[alpha_mm, lambda_mm] = mm_fit_gamma(whales);

fprintf('Problem B\nEstimating Result of Method of Moments:\n')
fprintf('alpha_hat : %.4f\nlambda_hat : %.4f\n\n', alpha_mm, lambda_mm)

%% Problem C - Maximum Likelihood
% Estimate parameters by the method of maximum likelihood
[alpha_ml, lambda_ml] = ml_fit_gamma(whales);

fprintf('Problem C\nEstimating Result of Maximum Likelihood:\n')
fprintf('alpha_hat : %.4f\nlambda_hat : %.4f\n\n', alpha_ml, lambda_ml)

%% Problem D - Plot Results
% Generate the x-coordinate
x = floor(min(whales)):0.01:ceil(max(whales));

% Plot histogram of source data
figure
yyaxis left
histogram(whales, 20), grid on
set(gca, 'FontSize', 12)
xlabel('Time (in hours) to swim 1 km')

% Plot the distribution estimated by
% 1. the method of moments
% 2. the method of maximum likelihood
yyaxis right
plot(x, gampdf(x, alpha_mm, lambda_mm), 'LineWidth', 2)
axis([-inf inf 0 2.5])
hold on
plot(x, gampdf(x, alpha_ml, lambda_ml), 'LineWidth', 2)
hold off

legend('Source Data', 'Method of Moments', 'Maximum Likelihood')

%% Problem E - Sampleing Distribution & Standard Error
%  of the parameters fit by the method of moments by using bootstrap
fprintf('Problem E\n')
[alpha_info_mm, lambda_info_mm] = ...
    bootstrap_result(whales, alpha_mm, lambda_mm, 'mm');

%% Problem F - Sampleing Distribution & Standard Error
%  of the parameters fit by the method of maximum likelihood
%  by using bootstrap
fprintf('Problem F\n')
[alpha_info_ml, lambda_info_ml] = ... 
    bootstrap_result(whales, alpha_ml, lambda_ml, 'mle');

%% Problem G - 95% Confidence Intervals
%  for the parameters estimated by maximum likelihood
% 95% Confident interval of estimated alpha
alpha_c1 = prctile(alpha_info_ml.all, 2.5);
alpha_c2 = prctile(alpha_info_ml.all, 97.5);
alpha_ci = [2*alpha_ml - alpha_c2, 2*alpha_ml - alpha_c1];

% 95% Confident interval of estimated lambda
lambda_c1 = prctile(lambda_info_ml.all, 2.5);
lambda_c2 = prctile(lambda_info_ml.all, 97.5);
lambda_ci = [2*lambda_ml - lambda_c2, 2*lambda_ml - lambda_c1];

fprintf('Problem G\n')
fprintf(['95%% confidence interval of the parameters estimated\n' ...
         'by maximum likelihood is: \n' ...
         'alpha: [%f, %f]\nlambda: [%f, %f]\n\n'], ... 
         alpha_ci(1), alpha_ci(2), lambda_ci(1), lambda_ci(2))