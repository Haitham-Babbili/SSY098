function [ img_array, labels ] = random_subset( data, K )
%RANDOM_SUBSET Extract K examples from data randomly.
%   Input arguments :
%   - data : a data set contains images
%   - K : the number of images in subset
%   - Output :
%   - image_array : a matrix combined by images in subset, whose size is 
%   32x32x1xK here
%   - labels : labels for images in subset
% Author: Qixun Qu

% Obtain the number of images in data
data_num = length(data.imgs);

% Obtain the size of each image in data
[rows, cols, chans] = size(data.imgs{1});

% Generate K random numbers from 1 to the length of data,
% indicating which examples will be extracted from data
subset = randi(data_num, K, 1);

% Initialize the matrix to hold images in subset
img_array = zeros(rows, cols, chans, K);

for i = 1 : K
    
    % Put each image into the matrix
    img_array(:, :, :, i) = data.imgs{subset(i)};
    
end

% Convert the matrix value to single class
img_array = single(img_array);

% Obtain labels for examples in subset
labels = data.labels(subset);

end

