%% Bonus 1 - Problem b
% By Qixun Qu
% 2017/02/02
% Bonus Assignment 1 of
% Statistic Inference

%% Clean Environment
clc
clear
close all

%% Load Data
load families.mat
data_num = size(families, 1);

%% 100 Samples of Size 400
% Set the sample size
each_sample_size = 400;

% Obtain average and standard deviation of all samples
% And confident intervals for all samples
[mean_avg_ehh_400, std_avg_ehh_400, ehh_ci_400] = ...
    proB_process( families, data_num, each_sample_size );

% Print results
print_B_result(each_sample_size, mean_avg_ehh_400, std_avg_ehh_400, ehh_ci_400)

%% 100 Samples of Size 100
% Set the sample size
each_sample_size = 100;

% Obtain average and standard deviation of all samples
% And confident intervals for all samples
[mean_avg_ehh_100, std_avg_ehh_100, ehh_ci_100] = ...
    proB_process( families, data_num, each_sample_size );

% Print results
print_B_result(each_sample_size, mean_avg_ehh_100, std_avg_ehh_100, ehh_ci_100)