close all
% clear
clc

A = [ 0        0         1       0;
      0        0         0       1;
     -700      700      -52.84   0;
      247.92  -247.92    0       0];
B = [0; 0; 98.4; 0];
C = [1 0 0 0;    % theta1
     -1 1 0 0];  % alpha = theta2 - theta1
D = 0;

G = ss(A, B, C, D);

% Load Data
load('Data1\Theta1.mat');  % Theta1
load('Data1\Voltage.mat'); % Voltage
% Remove Mean
Voltage = Voltage - mean(Voltage);
Theta1 = Theta1 - mean(Theta1);
% Discrete System:
Ts = 1;
t = 1:Ts:size(Voltage, 1);
a = lsim(bj101129, Voltage, t);
b = lsim(G, Voltage, t);
%a = lsim(G, u, t);
figure(1)
set(gcf, 'Position', get(0, 'Screensize'));
plot(a(:,1), 'r', 'LineWidth', 1); grid on
hold on
plot(b(:,1)/(180/pi), 'b', 'LineWidth', 1)
plot(Theta1, 'k', 'LineWidth', 1)
legend('BJ Model', 'Physical Model', 'Measured Data')
axis([0 20001 -30 30])
title('Simulations of BJ Model and Physical Model', ...
      'FontSize', 30);
set(gca, 'FontSize', 24);
xlabel('Time', 'FontSize', 28);
ylabel('Theta1', 'FontSize', 28);