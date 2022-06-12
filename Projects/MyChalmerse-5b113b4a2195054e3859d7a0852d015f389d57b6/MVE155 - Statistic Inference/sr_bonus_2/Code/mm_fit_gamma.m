function [ alpha, lambda ] = mm_fit_gamma( data )
%MM_FIT_GAMMA Estimated parameters to fit Gamma distribution by the method
%of moments.
%   Input argument:
%   - data : the source data
%   Outputs:
%   - alpha, lambda : parameters of Gamma distribution need to be estimated

% Obtain the mean of data
data_mean = mean(data);

% Obtain the mean of squared data
data_square_mean = mean(data.^2);

% Compute the estimated alpha by equation
%                     x_bar_square
% alpha = -------------------------------------
%              x_square_bar - x_bar_square
% lambda = x_bar / alpha
alpha = data_mean^2 / (data_square_mean - data_mean^2);
lambda = data_mean / alpha;

end

