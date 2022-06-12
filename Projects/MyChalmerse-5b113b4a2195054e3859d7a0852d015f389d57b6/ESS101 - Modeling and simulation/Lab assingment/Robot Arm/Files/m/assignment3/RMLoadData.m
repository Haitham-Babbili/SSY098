function [ est_WD, est_VD ] = RMLoadData( N, Ts )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

%%
% Sampling Time
if (nargin < 2)
    Ts = 0.001; end
% Number of Working Data
if (nargin < 1)
    N = 10001;  end

%% Load Data
% Black
% load('Data1\Theta1.mat');  % Theta1
% load('Data1\Voltage.mat'); % Voltage
% Grey
load('GreyData\Theta1.mat');  % Theta1
load('GreyData\Voltage.mat'); % Voltage
Theta1 = Theta1_grey;
Voltage = Voltage_grey;
clear Theta1_grey Voltage_grey;
% Remove Mean
% Black
% Theta1 = Theta1 - mean(Theta1);
% Grey
Theta1 = Theta1 - mean(Theta1);
% Working Data
Theta1_WD = Theta1(1:N);
Voltage_WD = Voltage(1:N);
est_WD = iddata(Theta1_WD, Voltage_WD, Ts);
% Validation Data
Theta1_VD = Theta1(N+1:end);
Voltage_VD = Voltage(N+1:end);
est_VD = iddata(Theta1_VD, Voltage_VD, Ts);

end

