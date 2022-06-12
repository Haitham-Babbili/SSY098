%% Assignment 3
clc;
clear;
close all;

%% Load Data
N = 10001;
Ts = 0.001;
[est_WD, est_VD] = RMLoadData(N, Ts);

%% Estimation
S = 300;
est_MTD = {'arx' 'oe' 'armax' 'bj'};
goodEst = [];
fitEst = 0;
rstEst = [];
svFd = 'GreyData\'; % Grey
% svFd = 'DataEst\'; % Black
for i = 1 : size(est_MTD, 2)
   [goodEst, fitEst, rstEst] = ...
       RMEstimation( est_MTD{i}, est_WD, est_VD, S );
   save([svFd est_MTD{i} '.mat'], ...
       'goodEst', 'fitEst', 'rstEst');
end

%% Plot Result
allMats = RMCmpPlot(est_VD, est_MTD, Ts, svFd);

