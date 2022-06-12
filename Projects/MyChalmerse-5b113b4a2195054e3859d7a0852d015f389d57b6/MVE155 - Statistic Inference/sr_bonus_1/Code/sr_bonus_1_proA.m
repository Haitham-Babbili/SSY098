%% Bonus 1 - Problem a
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
% The population in total
data_num = size(families, 1);

%% Calculate from Samples
% The number of population in each sample
each_sample_size = 500;
% The number of samples
iterat_num = 5;

% i. Proportion of male-headed families of 5 samples.
ppt_mhf = zeros(iterat_num, 1);
% ii. Average number of persons per family of 5 samples.
avg_ppf = zeros(iterat_num, 1);
% iii. Proportion of heads of households who
% received at least a Bachelor's degree of 5 samples.
ppt_hhB = zeros(iterat_num, 1);

for i = 1 : iterat_num
    
    idx = randi(data_num, each_sample_size, 1);
    
    % Obtain the proportion of male-headed families in each sample
    ppt_mhf(i) = length(find(families(idx, 1) == 2)) / each_sample_size;
    % Obtain the average number of persons per family in each sample
    avg_ppf(i) = mean(families(idx, 2));
    % Obtain the proportion of heads of households who received at 
    % least a Bachelor's degree in each sample
    ppt_hhB(i) = length(find(families(idx, 6) >= 43)) / each_sample_size;
    
end

%% Calculate Estimated Standard Errors
% Compute the estimated standard error for each parameter
ppt_mhf_est_err = std(ppt_mhf) / sqrt(iterat_num);
avg_ppf_est_err = std(avg_ppf) / sqrt(iterat_num);
ppt_hhB_est_err = std(ppt_hhB) / sqrt(iterat_num);

%% Calculate 95% Confident Intervals (CI)
% Calculate 95% confident interval for each parameter
ci_ppt_mhf = [mean(ppt_mhf) - 1.96 * ppt_mhf_est_err, ...
              mean(ppt_mhf) + 1.96 * ppt_mhf_est_err];
ci_avg_ppf = [mean(avg_ppf) - 1.96 * avg_ppf_est_err, ...
              mean(avg_ppf) + 1.96 * avg_ppf_est_err];
ci_ppt_hhB = [mean(ppt_hhB) - 1.96 * ppt_hhB_est_err, ...
              mean(ppt_hhB) + 1.96 * ppt_hhB_est_err];

%% Print Result
fprintf('Estimated Standard Errors:\n')
fprintf('- Proportion of male-headed families: %f;\n',...
        ppt_mhf_est_err)
fprintf('- Average number of persons per family: %f;\n',...
        avg_ppf_est_err)
fprintf(['- Proportion of heads of households who\n'...
        'received at least a Bachelor\''s degree: %f.\n\n'],...
        ppt_hhB_est_err)
    
fprintf('Confident Intervals of:\n')
fprintf('- Proportion of male-headed families: [%f, %f];\n',...
        ci_ppt_mhf(1), ci_ppt_mhf(2))
fprintf('- Average number of persons per family: [%f, %f];\n',...
        ci_avg_ppf(1), ci_avg_ppf(2))
fprintf(['- Proportion of heads of households who\n'...
        'received at least a Bachelor\''s degree: [%f, %f].\n\n'],...
        ci_ppt_hhB(1), ci_ppt_hhB(2))
