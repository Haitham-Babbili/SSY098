%%
% Sampling Time
Ts = 0.001;
% Number of Working Data
N = 10001;

%% Load Data
load('GreyData\Theta1.mat');  % Theta1
load('GreyData\Voltage.mat'); % Voltage
% Remove Mean
Theta1_grey = Theta1_grey - mean(Theta1_grey);
% Working Data
Theta1_WD = Theta1_grey(1:N);
Voltage_WD = Voltage_grey(1:N);
est_WD = iddata(Theta1_WD, Voltage_WD, Ts);
% Validation Data
Theta1_VD = Theta1_grey(N+1:end);
Voltage_VD = Voltage_grey(N+1:end);
est_VD = iddata(Theta1_VD, Voltage_VD, Ts);

est = arx(est_WD, [10 10 6])
compare(est_VD, est)
A = [0 1; 0 -0.898/J];
B = [0; 0.1673/J];
C = [0 1];
D = zeros(1,1);