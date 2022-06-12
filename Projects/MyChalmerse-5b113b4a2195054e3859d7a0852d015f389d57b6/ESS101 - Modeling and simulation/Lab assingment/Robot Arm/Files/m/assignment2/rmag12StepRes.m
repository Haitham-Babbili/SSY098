%% Clear Enviornmrnt
clc;
clear;
close all;

%% Get State Space Model
A = [ 0        0         1       0;
      0        0         0       1;
     -700      700      -52.84   0;
      247.92  -247.92    0       0];
B = [0; 0; 98.4; 0];
C = [1 0 0 0;    % theta1
     0 0 1 0;    % dirivative of theta1
     -1 1 0 0];  % alpha = theta2 - theta1
D = [0; 0; 0];
% State space model
G = ss(A, B, C, D);
%% Show step response
t = 0:0.001:10;
y = step(G, t);
y(:,1) = y(:,1) * (180/pi);
y(:,3) = y(:,3) * (180/pi);
% y(:,1) contains values of theta1
% y(:,2) contains values of dirivative of theta1
% y(:,3) contains values of alpha

%% Get transfer function
% tf(G)

%% Plot Response
figure
set(gcf, 'Position', get(0, 'Screensize'));
% Plot theta1
subplot(3, 1, 1)
plot(t, y(:, 1), 'k', 'LineWidth', 1); grid on
axis([0 10 0 1200])
set(gca, 'FontSize', 16, 'YTick', (300:300:2100))
xlabel('Time', 'FontSize', 20)
ylabel('Theta1', 'FontSize', 20)
title('Original Response', 'FontSize', 24)
% Plot dTheta1
subplot(3, 1, 2)
plot(t, y(:, 2), 'k', 'LineWidth', 1); grid on
axis([0 10 0 2.5])
set(gca, 'FontSize', 16, 'YTick', [0 1 2 2.5])
xlabel('Time', 'FontSize', 20)
ylabel('dTheta1', 'FontSize', 20)
% Plot alpha
subplot(3, 1, 3)
plot(t, y(:, 3), 'k', 'LineWidth', 1); grid on
axis([0 10 -4.5 2])
set(gca, 'FontSize', 16, 'YTick', [-4.5 -2.5 0 2])
xlabel('Time', 'FontSize', 20)
ylabel('Alpha', 'FontSize', 20)
