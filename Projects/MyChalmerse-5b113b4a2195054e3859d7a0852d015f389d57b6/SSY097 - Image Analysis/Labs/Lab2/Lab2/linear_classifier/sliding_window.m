function prob = sliding_window( img, w, w0 )
%SLIDING_WINDOW Convoluting the input image with parameters to obtain the
%probability of each pixel to be a point in traffic sign.
%   Input arguments:
%   - img: an image that has a traffic sign
%   - w : a parameter in matrix
%   - w0 : a number parameter
%   Output:
%   - prob : a matrix consists of sigmoid result in each pixel, indicating
%   the probability of each pixel to be a point in traffic sign, the size
%   of prob is same as the input image
% Author: Qixun Qu

% Obtain the size of input image
[rows, cols, chans] = size(img);

% Initialize a matrix to hold the convolution result
img_filt = zeros(rows, cols, chans);

for i = 1 : chans
    % Carrying out convolution in each channel
    img_filt(:, :, i) = imfilter(img(:, :, i), w(:, :, i), 'symmetric');

end

% Add the number parameter to the convolution result
y = sum(img_filt, 3) + w0;

% Calculate the probability of each pixel
prob = sigmoid(y);

end

