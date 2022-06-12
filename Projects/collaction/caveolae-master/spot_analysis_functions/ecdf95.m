function cdf = ecdf95(x)
  % Compute the empirical cumulative distribution function (ecdf) and a
  % 95% confidence interval using the using DKW inequality
  % 
  % Input:
  %   x - a 1D column vector
  %
  % Output: A table with following columns:
  %   x | f | lb | ub
  %   where:
  %   xs - x sorted in ascending order
  %   f - Estimated ECDF 
  %   lb - Lower bound of a 95% CI
  %   ub - Upper bound of a 95% CI
  %
  % Refs: 
  % - https://en.wikipedia.org/wiki/Empirical_distribution_function
  % - https://en.wikipedia.org/wiki/Dvoretzky-Kiefer-Wolfowitz_inequality
  % - http://web.as.uky.edu/statistics/users/pbreheny/621/F10/notes/8-26.pdf
  %
  % (c) Raibatak Das, 2018
  % MIT License

  n = length(x(:));
  xs = sort(x(:));
  f = (1:n)'/n;
 
  % Compute confidence interval
  e = sqrt(log(2/0.05)/(2*n));
  lb = f - e;
  lb(lb < zeros(n,1)) = 0;
  ub = f + e;
  ub(ub > ones(n,1)) = 1;
  
  % Create output table
  cdf = array2table([xs, f, lb, ub], 'VariableNames', {'xs', 'f', 'lb', 'ub'});
end
