function est_ALL = RMLoadDGreyData( Ts, Ns )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

%%
% Sampling Time
if (nargin < 2)
    Ns = 2;     end
if (nargin < 1)
    Ts = 0.001; end

%% Load Data
load('GreyData\Theta1_grey.mat');  % Theta1_grey
load('GreyData\Voltage_grey.mat'); % Voltage_grey
% 
Theta1_grey = -Theta1_grey/(180/pi);
ttlNum = size(Theta1_grey, 1);
echNum = floor(ttlNum/Ns);
% Separating Data
row = 0;
est_ALL = {};
for i = 1 : Ns
    Theta1_grey_P = Theta1_grey(row+1:echNum*i);
    Voltage_grey_P = Voltage_grey(row+1:echNum*i);
    est_P = iddata(Theta1_grey_P, Voltage_grey_P, Ts);
    est_ALL{i} = est_P;
    row = echNum*i;
end

end

