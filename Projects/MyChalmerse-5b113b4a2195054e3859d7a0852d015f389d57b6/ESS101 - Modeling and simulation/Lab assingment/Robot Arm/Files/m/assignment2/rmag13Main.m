%%
%
%   2016/10/13 22:00

%% Clear enviornmrnt
clc;
clear;
close all;

%% Set Parameters
%------------------------
% Name    |    Default
%------------------------
% N       |    64
% Rm      |    3.21
% Klin    |    1.19
% t       |    0:0.001:10
%------------------------
t = 0:0.001:10;
RMPrs = {64  3.21 1.19; % Default Values
         128 3.21 1.19; % Modify Gear Ratio N to 128
         64  1.6  1.19; % Modify Resistor Value to 1.6
         64  3.21 2.4}; % Modify String Constant to 2.4
RMTls = {'Original Response';
         'Modify Gear Ratio to 128';
         'Modify Resistor Value to 1.6';
         'Modify Spring Constant to 2.4'};

%% Plot Response
N = size(RMPrs, 1);
for i = 1 : N
    % Get Response
    [~, RMRes] = rmag13State(RMPrs{i,:}, t);
    % Plot Response
    rmag13ResPlot(RMRes, t, RMTls{i})
end
