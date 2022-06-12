function [ alpha_info, lambda_info ] = paras_std_err( data, alpha, lambda )
%ALPHA_STD_ERROR Compute the standard error of estimated parameter alpha.
%   Input arguments:
%   - data : a vector consistd of source data
%   - alpha : the estimated parameter alpha by the method of monments or
%   the method of maximum likelihood.
%   - lambda : the estimated parameter lambda by the method of monments or
%   the method of maximum likelihood.
%   Output:
%   - std_err : the standard error of estimated parameter alpha
%   - all_alpha : the estimated parameter alpha of all samples

% Obtain the length of source data
n = length(data);

% Set the number of samples
B = 1000;

% Generate the samples, the size of gam_dis is B x n
gam_dis = gamrnd(alpha * ones(B, n), lambda * ones(B, n));

% Initialize a vector to store all estimated alpha and lambda
all_alpha = zeros(B,1);
all_lambda = zeros(B, 1);

for i = 1 : B
    
    % Calculate estimated alpha for each sample
    [all_alpha(i), all_lambda(i)] = mm_fit_gamma(gam_dis(i, :));

end

% Format the structure of estimated alpha and lambda
alpha_info = struct('all', all_alpha, ...
                    'mean', mean(all_alpha), ...
                    'std', std(all_alpha));
                
lambda_info = struct('all', all_lambda, ...
                     'mean', mean(all_lambda), ...
                     'std', std(all_lambda));

end

