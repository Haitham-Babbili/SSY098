function ci = compute_CI( data )
%COMPUTE_CI Compute 95% confident interval for given data.

std_err = std(data) / sqrt(length(data));
ci = [mean(data) - 1.96 * std_err, mean(data) + 1.96 * std_err];

end