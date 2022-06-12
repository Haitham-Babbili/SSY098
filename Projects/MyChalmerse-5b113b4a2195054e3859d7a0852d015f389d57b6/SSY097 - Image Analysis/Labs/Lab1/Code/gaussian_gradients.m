function [ grad_x, grad_y ] = gaussian_gradients( image, std_dvt )
%GAUSSIAN_GRADIENTS Obtain the gradients in X and Y direction respectively
%of the image that is smoothed by a gaussian filter.
%   Input arguments:
%   - image : the image that needs to be extracted gradients
%   - std_dvt : standard deviation determins the width of normal
%   distribution and the size of the gaussian filter
%   Outputs:
%   - grad_x : the gradient in X direction
%   - grad_y : the gradient in Y direction
% Author: Qixun Qu

% Obtain filtered image first to keep information that will not change
% with scale, which is also known as scale-invariant features
filt_img = gaussian_filter(image, std_dvt);

% Calculate gradient in Y direction
% The image boundary is padded by its mirror-reflecting
grad_y = imfilter(filt_img, [-0.5 0 0.5]', 'symmetric');

% Calculate gradient in X direction
% The image boundary is padded by its mirror-reflecting
grad_x = imfilter(filt_img, [-0.5 0 0.5], 'symmetric');

end