function [ alpha, lambda ] = ml_fit_gamma( data )
%ML_FIT_GAMMA Estimated parameters to fit Gamma distribution by the method
%of maximum likelihood.
%   Input argument:
%   - data : the source data
%   Outputs:
%   - alpha, lambda : parameters of Gamma distribution need to be estimated
%--------------------------------------------------------------------------
%   The alpha is the solution of the equation
%   log(alpha) = log(x_bar) - log(t2)/n + Gamma'(alpha)/Gamma(alpha)
%   In this function, the formation of this equation is
%   f = log(alpha) - cons_item - psi(alpha), where
%   cons_item = log(x_bar) - log(t2)/n,
%   psi(alpha) = Gamma'(alpha)/Gamma(alpha)
%   The alpha will be found by solving f = 0,
%   lambda = x_bar / alpha.

% Obtain the length of the number
n = length(data);

% Obtain the multiplicative result of all elements
% in source data
t2 = prod(data);

% Calculate the mean of the data
data_mean = mean(data);

% Calculate the constant item in the equation
global cons_item
cons_item = log(data_mean) - 1/n * log(t2);

% Compute the initial alpha by applying the method of moments
[alpha_ini, ~] = mm_fit_gamma(data);

% Estimate alpha by solve f = 0 in range of (0, 10*alpha_ini]
alpha = fzero(@derivative_to_alpha, [1e-5, 10*alpha_ini]);

% Compute lambda
lambda = data_mean / alpha;

end

function f = derivative_to_alpha(alpha)
%DERIVATIVE_TO_ALPHA The partial derivative of likelihood function with
%respect to alpha

global cons_item

% Form the equation
f = log(alpha) - cons_item - psi(alpha);

end