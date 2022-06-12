%% Clean up
clc;
clear;
close all;

%% Task 1
T = 0.01;           % Sampling Time
n = 4;              % Number of Variables
p = 2;              % Number of Outputs
A = [1 T 0 0;       % State Transition Matrix
     0 1 0 0;
     0 0 1 T;
     0 0 0 1];
%wk = [0 T 0 T]';   % Process Noise Matrix
C = [1 0 0 0;       % Measurement Matrix
     0 0 1 0];

%% Task 2
x = 0:0.01:9.99;                % True X Positions
xt = x(1:100*T:end);            % Sampling X Positions
y = [ones(1, 499) 1:-0.002:0];  % True Y Positions
yt = y(1:100*T:end);            % Sampling Y Positions
Y = [xt; yt];                   % True Trajectories
Z = Y + 0.1*randn(size(Y));     % Measured Trajectories

%% Task 3 & 4
q = 1e0;           % Factor of Q
Q = q*[0 0 0 0;    % Covariance Matrix of Process Noise
       0 T^2 0 0;  % Q = q*(wk.*wk');
       0 0 0 0;    % Q(2,4) = 0;
       0 0 0 T^2]; % Q(4,2) = 0;
r = 1e0;           % Factor of R
R = r*eye(p);      % Convariance Matrix of Measurement Noise
x0 = zeros(n, 1);  % Estimate of x(0)
pz = 1e6;          % Factor of P0
P0 = pz*eye(n);    % Error Covariance for x(0)

% Filter Measured Trajectories
% Xfilt: Kalman-filtered Estimate of States
% - Xfilt[1,:]: X Position
% - Xfilt[2,:]: X Velocity
% - Xfilt[3,:]: Y Position
% - Xfilt[4,:]: Y Velocity
% P: Covariance Matrix of Last Xfilt Element
[Xfilt, P] = kalmfilt(Z, A, C, Q, R, x0, P0);

%% Plot
% Plot Trajectories
% Before Filtering
figure (1)
plot(Y(1,:), Y(2,:), '.', Z(1,:), Z(2,:), '.')%;grid on
set(gca, 'FontSize', 14)
axis([-inf inf -0.2 1.2])
xlabel('X Positions'); ylabel('Y Positions')
lg1 = legend('True', 'Measured', 'Location', 'southwest');
title(lg1, 'Trajectories')
% Plot Filtered Result
% Get Original Speed
vx = diff(xt)/T;
vy = diff(yt)/T;
t = (1:length(vx))*T;
% Comparison
figure (2)
set(gcf, 'Position', [0 200 1500 330])
% After Filtering Trajectories
subplot(1,3,1)
plot(Y(1,:), Y(2,:), '.', Xfilt(1,1:end-1), Xfilt(3,1:end-1), '.')
set(gca, 'FontSize', 12)
axis([-inf inf -0.2 1.2])
xlabel('X Positions'); ylabel('Y Positions')
lg2 = legend('True', 'Estimated', 'Location', 'southwest');
title(lg2, 'Trajectories')
% X Velocity
subplot(1,3,2)
plot(t, vx, t, Xfilt(2,2:end-1), 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
axis([0 10 0.5 1.5])
xlabel('Time'); ylabel('X Velocity')
legend('True', 'Estimated', 'Orientation', 'horizontal');
title(['T=' num2str(T) ', q=' num2str(q) ', r=' num2str(r)], 'FontSize', 16)
% Y Velocity
subplot(1,3,3)
plot(t, vy, t, Xfilt(4,2:end-1), 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
axis([0 10 -0.5 0.5])
xlabel('Time'); ylabel('Y Velocity')
legend('True', 'Estimated', 'Orientation', 'horizontal');
clear lg1 lg2