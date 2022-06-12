function nongoals_cell = get_nongoals_cell( img, position, radius, mask_size )
%GET_NONGOALS_CELL Get non-target cells in the given image.
%   Input arguments:
%   - img : the given image
%   - position : the known positions of cells
%   - radius : the radius rough region of a cell, default and the maximum 
%     value is 13
%   - mask_size : the size of the mask of a patch, default value is 35
%   Output:
%   - nongoals_cell : a mask for non-target cells
% Author: Qixun Qu

% Set default values
if nargin < 4
    mask_size = 35;
end

if nargin < 3
    radius = 13;
elseif nargin >2
    radius = max(radius, 13);
end

% Obtain the mask of rough cell region
mask = get_cell_mask(img, position, radius, mask_size);

% Get the invers mask of cells, now the white region is non-cell area
% in other word, it is background
bg = rgb2gray(img) .* (1 - mask);
% Use the median of ground to fill the cell region
bg(bg == 0) = median(bg(bg > 0));

% Binarize the image to select non-target region
% use -log(bg) to enhance the background
% nongoals = imbinarize(-log(bg));
% For Matlab before R2016b
nongoals = im2bw(-log(bg), 0.6);
% Fill the holes in the non-target cells' region
nongoals = imfill(nongoals, 'holes');

% Dilate the non-target cells' region to obtain the
% beughbor area of non-target cells
se = strel('disk', 2);
nongoals_cell = imdilate(nongoals, se);

end