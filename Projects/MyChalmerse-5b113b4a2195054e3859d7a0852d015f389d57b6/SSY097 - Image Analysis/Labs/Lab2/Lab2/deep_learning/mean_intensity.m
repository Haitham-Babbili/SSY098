function data_mean = mean_intensity( data )
%MEAN_INTENSITY Compute the mean intensity image of data.
%   Input argument:
%   - data : an image set
%   Output:
%   - data_mean : the mean intensity image of data
% Author: Qixun Qu

% Obtain the number of images in data
data_num = length(data.imgs);

% Initialize a matrix to be assigned of mean intensity
data_mean = zeros(size(data.imgs{1}));

for i = 1 : data_num

    % Accumulate all image to the matrix
    data_mean = data_mean + data.imgs{i};

end

% Compute the mean intensity image
data_mean = data_mean / data_num;

end

