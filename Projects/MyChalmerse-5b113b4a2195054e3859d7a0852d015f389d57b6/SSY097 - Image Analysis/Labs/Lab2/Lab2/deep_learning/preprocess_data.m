function data_norm = preprocess_data( data )
%PREPROCESS_DATA Normalize images in input data, first compute a mean
%intensity of all images, then subtract the mean from each image and
%product with 256.
%   Input argument:
%   - data : a data set contains images
%   Output:
%   - data_norm : the data has been normalized
% Author: Qixun Qu

% Obtain the number of images in data
data_num = length(data.imgs);

% Initialize normalized data
data_norm = data;

% Compute the mean intensity image of images in data
data_mean = mean_intensity(data);

for i = 1 : data_num
    
    % Subtract mean intensity from each image in dara,
    % and then product 256
    data_norm.imgs{i} = (data.imgs{i} - data_mean) * 256;
    
end

end

