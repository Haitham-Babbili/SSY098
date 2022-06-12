function digits_training = prepare_digits( digits_training )
%PREPARE_DIGITS This function is to calculate SIFT-like descriptor for each
%image in training set.
%   Input arguments:
%   - digits_training : a training set with 100 images, the scale of each
%   image is 39, the image center is [20, 20]
%   Outputs:
%   - digits_training: a new training set with SIFT-like descriptors
%   for each image
% Author: Qixun Qu

% Get the number of images in training set
num = length(digits_training);

% Set the position of each image's center and scale size of each image
% manually; in this case, the patch is the same as the full scale image
position = [20, 20];
scale = 39;

for i = 1 : num
    
    % Calculate each training image's descriptor, the descriptor is placed
    % in a new column which is named 'descriptor'
    digits_training(i).descriptor = ...
       gradient_descriptor(digits_training(i).image, position, scale);
   
end

end

