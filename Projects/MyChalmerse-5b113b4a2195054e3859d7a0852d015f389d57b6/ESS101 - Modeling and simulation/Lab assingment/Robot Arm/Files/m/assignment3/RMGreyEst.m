%% Grey-Box Estimation
clc;
clear;
close all;

%%
Ts = 0.001;
Ns = 4; % Ns = 1, 2, 4;
est_ALL = RMLoadDGreyData(Ts, Ns);

%% Linear Model
[greyMdls, est_Js] = RMGBLnr(est_ALL, Ns);
%RMGBCmpPlot( est_ALL, greyMdls, Ns );

est_Js
cov(est_Js(:,1)')
%% Nonlinear Model
% [nl_greyMdls, nl_est_Js] = RMGBNLnr(est_ALL, Ns);
% RMGBCmpPlot( est_ALL, nl_greyMdls, Ns );




