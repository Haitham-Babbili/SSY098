%% Bonus 1 - Problem c
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

%% The Incomes for Four Regions
% The amount of samples
region_num = 4;

% The size in each sample
each_sample_size = 400;

% A matrix to store sample data
region_income = zeros(each_sample_size, region_num);

for i = 1 : region_num

    % Extract sample from whole data
    region_population = length(find(families(:, 5) == i));
    idx = randi(region_population, each_sample_size, 1);
    region_income(:, i) = families(idx, 4);
    
end

% A boxplot to show incomes of four regions
boxplot(region_income, 'Labels', {'North', 'East', 'South', 'West'})
ylabel('Income')
grid on

%% Simple Random Sample
% Sample size
sample_size = 300;

% Extract data
idx = randi(data_num, sample_size, 1);
sample_income = families(idx, 4);

% Calculate confident interval for the sample
sample_income_mean = mean(sample_income);
sample_income_std_err = std(sample_income) / sqrt(sample_size) * ...
                        sqrt(1 - sample_size/data_num);

sample_income_ci = [sample_income_mean - 1.96 * sample_income_std_err, ...
                    sample_income_mean + 1.96 * sample_income_std_err];

% Print results
fprintf('------------------------------------------------\n')
fprintf('Simple random sample of size %d\n', sample_size)
fprintf('------------------------------------------------\n')
fprintf('Average income of sample: %.2f\n', sample_income_mean)
fprintf('Standard error of sample: %.2f\n', sample_income_std_err)
fprintf('95%% confident interval: [%.2f %.2f]\n', ...
        sample_income_ci(1), sample_income_ci(2))
fprintf('------------------------------------------------\n\n')
    
%% Proportional Allocation
% The number of stratums
family_type_num = 3;

% A vector to record the proportion of each stratum in population
each_strata_prop = zeros(family_type_num, 1);

for i = 1 : family_type_num
    
    % Compute proportion for each stratum
    each_strata_prop(i) = length(find(families(:, 1) == i)) / data_num;

end

% Set the sample size
sample_size = 300;

% Calculate the size of each stratum in sample
each_strata_size = round(sample_size * each_strata_prop);

fprintf('------------------------------------------------\n')
fprintf('Proportional Allocation\n')

% In the funciton of proC_process(), the mean, standard error and confident
% interval will be computed
[~, strata_sample_std, ~, each_strata_std] = ...
proC_process(families, family_type_num, each_strata_size, each_strata_prop);

%% Optimal Allocation
% Calculate the size of each stratum in sample
each_strata_size = round(sample_size .* each_strata_prop .* ...
                         each_strata_std / strata_sample_std);
               
% Compute proportion for each stratum
each_strata_prop = each_strata_size / sample_size;

fprintf('------------------------------------------------\n')
fprintf('Optimal Allocation\n')

% In the funciton of proC_process(), the mean, standard error and confident
% interval will be computed
proC_process(families, family_type_num, each_strata_size, each_strata_prop);
