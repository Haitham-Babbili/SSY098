function print_B_result( each_sample_size, mean_avg_ehh, std_avg_ehh, ehh_ci )

% Print results of estimates
fprintf('------------------------------------------------\n')
fprintf('100 samples with size of %d\n', each_sample_size)
fprintf('------------------------------------------------\n')
fprintf('Average of estimates: %f\n', mean_avg_ehh)
fprintf('Standard deviation of estimates: %f\n\n', std_avg_ehh)

% Print three confident intervals
fprintf('Confident Intervals of First 3 Samples:\n')
for i = 1 : 3
    fprintf('[%f, %f]\n',ehh_ci(i, 1), ehh_ci(i, 2))
end
fprintf('------------------------------------------------\n\n')

end

