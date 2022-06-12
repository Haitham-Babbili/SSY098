function [ strata_sample_mean, strata_sample_std, strata_sample_ci, each_strata_std ] = ...
         proC_process( data, type_num, strata_size, strata_prop )
% In this funciton, the mean, standard error and confident interval 
% of strtified sample will be computed

% Initialize vector to sore the mean, standard deviation and standard error
% for each stratum
each_strata_mean = zeros(type_num, 1);
each_strata_std = zeros(type_num, 1);
each_strata_std_err = zeros(type_num, 1);

for i = 1 : type_num

    % Extract datas for each stratum
    each_strata_pop = length(find(data(:, 1) == i));
    idx = randi(each_strata_pop, strata_size(i), 1);
    
    % Compute mean for each stratum
    each_strata_mean(i) = mean(data(idx, 4));
    
    % Compute unbiased standard deviation for each stratum
    % This is used to determine the optimal allocation
    each_strata_std(i) = std(data(idx, 4));
    
    % Compute standard error for each stratum
    each_strata_std_err(i) = std(data(idx, 4)) / sqrt(strata_size(i));

end

% Compute mean for stratified sample
strata_sample_mean = strata_prop' * each_strata_mean;

% Compute standard deviation for stratified sample
% This is used to determine the optimal allocation
strata_sample_std = strata_prop' * each_strata_std;

% % Compute standard error for stratified sample
strata_sample_std_err = sqrt(strata_prop'.^2 * each_strata_std_err.^2);

% Compute confident interval for stratified sample
strata_sample_ci = [strata_sample_mean - 1.96 * strata_sample_std_err,...
                    strata_sample_mean + 1.96 * strata_sample_std_err];

% Print results
fprintf('------------------------------------------------\n')
fprintf('Strata sample of size %d\n', sum(strata_size))
fprintf('Each strata has size of %d, %d and %d\n',...
        strata_size(1), strata_size(2), strata_size(3))
fprintf('------------------------------------------------\n')
fprintf('Average income: %.2f\n', strata_sample_mean)
fprintf('Standard error: %.2f\n', strata_sample_std_err)
fprintf('95%% confident interval: [%.2f %.2f]\n', ...
        strata_sample_ci(1), strata_sample_ci(2))
fprintf('------------------------------------------------\n\n')

end

