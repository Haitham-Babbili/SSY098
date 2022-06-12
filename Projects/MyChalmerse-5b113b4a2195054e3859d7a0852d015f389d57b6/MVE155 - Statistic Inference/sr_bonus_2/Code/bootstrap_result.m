function [ alpha_info, lambda_info ] = ...
    bootstrap_result( data, alpha, lambda, method )
%BOOTSTRAP_RESULT Obtain the result of bootstrap and present results in
%plots and text information.
%   Input arguments:
%   - data : source data to estimate the initial alpha and lambda
%   - alpha : initial shape parameter estimated from data by the method
%   - lambda : initial scale parameter estimated from data by the method
%   - method : the method to fit Gamma distribution,
%              'mm' for the method of moments,
%              'mle' for the method of maximum likelihood
%   Outputs:
%   - alpha_info : a struct that contains all alpha estimated from 1000
%   samples, the mean and standard error of these 1000 alpha
%   - lambda_info : a struct that contains all lambda estimated from 1000
%   samples, the mean and standard error of these 1000 lambda

% Obtain the method that the input parameters has been estimated by
if strcmp(method, 'mm')
    m_str = 'Moments';
elseif strcmp(method, 'mle')
    m_str = 'Maximum Likelihood';
else
    error('Wrong method!')
end

% Carry out bootstrap process and get information of
% samples' alpha and lambda, including:
% - 1000 values for 1000 samples
% - sample mean
% - sample standard error
[alpha_info, lambda_info] = ...
    paras_std_err(data, alpha, lambda);

% Estimated the distribution of alpha and lambda
% estimated from all samples
[alpha_dis_mu, alpha_dis_sigma] = normfit(alpha_info.all);
[lambda_dis_mu, lambda_dis_sigma] = normfit(lambda_info.all);

% Generate the x-coordinate
x1 = min(alpha_info.all) - 0.1:0.01:max(alpha_info.all) + 0.05;
x2 = min(lambda_info.all) - 0.1:0.01:max(lambda_info.all) + 0.05;

figure
set(gcf, 'Position', [200 200 1000 400]);

% Plot histogram and pdf of estimated alpha of all samples
subplot(1, 2, 1)
yyaxis left
histogram(alpha_info.all); grid on
set(gca, 'FontSize', 12)
title('Alpha')
xlabel({'Sampling Distribution of Alpha Fitted by'; ...
       ['the Method of ' m_str]})
yyaxis right
plot(x1, normpdf(x1, alpha_dis_mu, alpha_dis_sigma), 'LineWidth', 2)

% Plot histogram and pdf of estimated lambda of all samples
subplot(1, 2, 2)
yyaxis left
histogram(lambda_info.all); grid on
set(gca, 'FontSize', 12)
title('Lambda')
xlabel({'Sampling Distribution of Lambda Fitted by'; ...
       ['the Method of ' m_str]})
yyaxis right
plot(x2, normpdf(x2, lambda_dis_mu, lambda_dis_sigma), 'LineWidth', 2)

% Print standard error of two parameters
fprintf(['The standard errors of the parameters fit by the method\n' ...
         'of' m_str 'by using the bootstrap are: \n' ... 
         'standard error of alpha: %f\n' ... 
         'standard error of lambda: %f\n\n'], ...
         alpha_info.std, lambda_info.std)

end

