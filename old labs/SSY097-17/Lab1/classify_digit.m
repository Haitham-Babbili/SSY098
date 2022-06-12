function label = classify_digit( digit_test, digits_training, position, scale )
%CLASSIFY_DIGIT Get the label of one test image which consists of a digit.
%   Input arguments:
%   - digit_test : a test image contains one digit
%   - digits_training : a training set of 100 images, each image has 72
%   SIFT-like descriptors
%   - position : the position of the test image's center in full scale
%   image
%   - scale : the size of the test image
%   Output:
%   - label : a number shows the digit in test set

% Set default values for position and scale of test image
% this is only for the test imgaes in digits.mat, since each test image has
% the same values of position and scale
if nargin < 3
    position = [20, 20];
    scale = 39;
end

% Calculate the descriptor for test image, desc will be a 72 x 1 vector
desc = gradient_descriptor(digit_test, position, scale);

% Initialize the error to the maximum value, since the descriptor vector
% has 72 elements that are normalized from 0 to 1, the maximum error
% between two descriptors is 72 according to the error equation:
% sum((desc1 - desc2)^2)
error = 72;

% Initialize the label for one test image, -1 is not included in any
% posible results, if -1 appears in classification, which means there
% are mistakes in the process of computing descriptors
label = -1;

% Get the amount of images in training set
num = length(digits_training);

for i = 1 : num
    
    % Compare the descriptor of test image to each descriptor of training
    % image, calculate the error between two descriptors
    error_tmp = sum((desc - digits_training(i).descriptor).^2);
    
    % Reserve the label of one training image that has the minimum
    % difference with the test image
    if error_tmp < error
        error = error_tmp;
        label = digits_training(i).label;
    end
    
end

end

