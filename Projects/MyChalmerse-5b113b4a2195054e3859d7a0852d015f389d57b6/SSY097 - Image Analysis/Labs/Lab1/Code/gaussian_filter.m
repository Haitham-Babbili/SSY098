function filt_result = gaussian_filter( image, std_dvt )
%GAUSSIAN_FILTER Filtering image with gaussian filter.
%   Input arguments:
%   - image : an image that needs to be filtered
%   - std_dvt : standard deviation determins the width of normal
%   distribution and the size of the filter
%   Output:
%   - filt_result : the filtered image
% Author: Qixun Qu

% Construct gaussian filter, which is a square matrix with
% (4 * std_dvt) rows
gs_filter = fspecial('gaussian', 4 * std_dvt, std_dvt);

% Filtering image, the image boundary is padded by its mirror-reflecting
filt_result = imfilter(image, gs_filter, 'symmetric');

end

