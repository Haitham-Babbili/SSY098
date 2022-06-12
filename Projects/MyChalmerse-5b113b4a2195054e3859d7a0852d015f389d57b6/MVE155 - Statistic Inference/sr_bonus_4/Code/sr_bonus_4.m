%% Bonus Assignment 4
% By Qixun Qu
% 2017/03/04
% Bonus Assignment 4 of
% Statistic Inference

%% Clean Environment
clc
clear
close all

%% Prepare Data
% Load source data
load barium.mat

% Formula
% y = A + B*x
% y = ln(pressure)
% x = 1 / T, T is temperature
x = barium(:,1).^-1;
y = log(barium(:,2));

% Obtain the number of elements
n = length(x);

%% Compute Some Statistics
% Compute mean for x and y
mx = mean(x);
my = mean(y);

% Compute standard deviation
% for both x and y
sx = std(x);
sy = std(y);

% Compute covariance of x and y
covxy = cov(x, y);
sxy = covxy(2);

%% Estimate Parameters
% Comput coefficient of determination
r = sxy / (sx * sy);

% Do estimation
B_hat = r * sy / sx;
A_hat = my - B_hat * mx;

%% Compute Standard Error for Estimation
% Compute the estimator of residuals standard deviation
s = sqrt((n - 1) / (n - 2) * sy^2 * (1 - r^2));

% Calculate standard error for estimations of A and B
s_A_hat = s * sqrt(sum(x.^2)) / (sx * sqrt(n * (n - 1)));
s_B_hat = s / (sx * sqrt(n - 1));

fprintf('Estimation of A is: %.2f,\nits standard error is %.2f.\n\n', ...
         A_hat, s_A_hat)
fprintf('Estimation of B is: %.2f,\nits standard error is %.2f.\n\n', ...
         B_hat, s_B_hat)

%% Compute 95% Confident Interval
ci = 0.95;
alpha = 1 - (1 - ci)/2;

% Obtain P values from t distribution
% the degree of freedom is (n - 2)
p = tinv(alpha, n - 2);

ci_A_hat = p * s_A_hat;
ci_B_hat = p * s_B_hat;

fprintf(['95%% confident interval of A_hat is:%.2f' 177 '%.2f.\n'], ...
         A_hat, ci_A_hat)
fprintf(['95%% confident interval of B_hat is:%.2f' 177 '%.2f.\n\n'], ...
         B_hat, ci_B_hat)

%% Plot Regression Line and Residuals
% Calculate regression line and residuals
y_hat = A_hat + B_hat * x;
residuals = y - y_hat;

% Plot regression line
figure
plot(x, y, 'k.'), grid on
hold on
plot(x, y_hat, 'r')
set(gca, 'FontSize', 12)
xlabel('Temperature^{-1}')
ylabel('ln(pressure)')
axis([-inf inf -inf inf])
legend('Measurements', 'Regression Line')

% Plot residuals
figure
plot(x, residuals, 'k.'), grid on
hold on
plot(x, zeros(n, 1), 'r')
set(gca, 'FontSize', 12)
xlabel('Temperature^{-1}')
ylabel('Residuals')
axis([-inf inf -2 2])
legend('Residuals', 'Zero Line')
