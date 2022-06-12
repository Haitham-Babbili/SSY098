%% Clear Environment
clc;
clear;
close all;

%% Load Original Data
%  generated by Simulink - run rm_sin.mdl
load 'rm_sin_alpha'
load 'rm_sin_theta1'

y01 = Theta1(:,2);
y02 = Alpha(:,2);
t0 = Alpha(:,1);

%% Get Results in Differetn Step Size
% Step Size 0.01
h1 = 0.01;
[y11, y12, t1] = rmag42fAB2(h1);
% Step Size 0.02
h2 = 0.02;
[y21, y22, t2] = rmag42fAB2(h2);
% Step Size 0.04
h3 = 0.04;
[y31, y32, t3] = rmag42fAB2(h3);

%% Plot Results
figure (1)
set(gcf, 'Position', get(0, 'Screensize'));
subplot(2, 2, 1)
plot(t0, y01, 'k', 'LineWidth', 1); grid on
hold on
plot(t1, y11, 'r', 'LineWidth', 1)
plot(t2, y21, 'b', 'LineWidth', 1)
l = legend('Original', 'h=0.01', 'h=0.02', ...
       'Location', 'northoutside', 'Orientation', 'horizontal');
title(l, 'AB2 Method in Different Step Size')
axis([0 10 0 1.2]);
set(gca, 'FontSize', 18);
ylabel('Theta1', 'FontSize', 24);

subplot(2, 2, 2)
plot(t3, y31, 'g', 'LineWidth', 1); grid on
legend('h=0.04',  'Location', 'southwest')
set(gca, 'FontSize', 18);

subplot(2, 2, 3)
plot(t0, y02, 'k', 'LineWidth', 1); grid on
hold on
plot(t1, y12, 'r', 'LineWidth', 1)
plot(t2, y22, 'b', 'LineWidth', 1)
axis([0 10 -0.03 0.03]);
set(gca, 'FontSize', 18);
xlabel('Time', 'FontSize', 24);
ylabel('Alpha', 'FontSize', 24);

subplot(2, 2, 4)
plot(t3, y32, 'g', 'LineWidth', 1); grid on
legend('h=0.04',  'Location', 'southwest')
set(gca, 'FontSize', 18);
xlabel('Time', 'FontSize', 24);
