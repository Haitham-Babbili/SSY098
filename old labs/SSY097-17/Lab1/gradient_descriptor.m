function desc = gradient_descriptor( image, position, scale )
%GRADIENT_DESCRIPTOR Return the SIFT_like descriptor of a patch in image.
%   Input arguments:
%   - image : a full scale image that contains the patch
%   - position : the position of the patch's center in full scale image
%   - scale : the size of the patch
%   Output:
%   - desc : 72 x 1 vector indicates the SIFT-like descriptor of the patch

% Standard deviation is propotional to the scale of patch
std_dvt = round(scale * 0.05);
% Filtering the full scale image with a gaussian filter
img_filt = gaussian_filter(image, std_dvt);
% Calculate the gradients in x and y direction
[img_gx, img_gy] = gaussian_gradients(img_filt, std_dvt);

% The patch is about to be devided into nine samll squares,
% according to the position and the scale of patch, compute nine centers
% and one radius for all small squares
[centres, radius] = place_regions(position, scale);

% Initialize a vector to store descriptor
% each small square has 8 descriptors, all nine small squares give 72
% descriptors
desc = zeros(72, 1);

for i = 1 : 9
    
    % Obtain x gradient and y gradient for the ith small squares
    patch_gx = get_patch(img_gx, centres(1, i), centres(2, i), radius);
    patch_gy = get_patch(img_gy, centres(1, i), centres(2, i), radius);
    
    % Compute the descriptors for the ith small square
    desc((i-1)*8+1 : i*8) = gradient_histogram(patch_gx, patch_gy);
    
end

% Normalized all descriptors
desc_max = max(desc);
desc_min = min(desc);
desc = (desc - desc_min) / (desc_max - desc_min);

end

