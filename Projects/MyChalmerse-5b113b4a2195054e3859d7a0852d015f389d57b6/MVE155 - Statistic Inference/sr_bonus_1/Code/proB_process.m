function [ mean_avg_ehh, std_avg_ehh, ehh_ci ] = ...
    proB_process( data, data_num, each_sample_size )

% The amount of samples
iterat_num = 100;

% Average Education Level of Head of Household
ehh_avg = zeros(iterat_num, 1);

% Initialize a matric to store all samples' confident intervals
ehh_ci = zeros(iterat_num, 2);

for i = 1 : iterat_num

    % Extract random data for each sample
    idx = randi(data_num, each_sample_size, 1);
    
    % Compute average for each sample
    ehh_avg(i) = mean(data(idx, 6));
    % Compute standard deviation for each sample
    ehh_std_error = std(data(idx, 6)) / sqrt(each_sample_size) * ...
                    sqrt(1 - each_sample_size / data_num);
    % Compute confident interval for each sample
    ehh_ci(i, :) = [ehh_avg(i) - 1.96 * ehh_std_error, ...
                    ehh_avg(i) + 1.96 * ehh_std_error];
    
end

% Average and Standard Deviation of 100 Estimates
mean_avg_ehh = mean(ehh_avg);
std_avg_ehh = std(ehh_avg);

% figure
% histogram(avg_ehh, 10)

% Normal Density of Estimates
% x = min(avg_ehh) - 0.05 : 0.01 : max(avg_ehh) + 0.05;
x = 38.5 : 0.01 : 40.5;
nor_avg_ehh = normpdf(x, mean_avg_ehh, std_avg_ehh);

% Plot histogram of estimates and normal density
figure
yyaxis left
histogram(ehh_avg, 10)
yyaxis right
plot(x, nor_avg_ehh), grid on

end

