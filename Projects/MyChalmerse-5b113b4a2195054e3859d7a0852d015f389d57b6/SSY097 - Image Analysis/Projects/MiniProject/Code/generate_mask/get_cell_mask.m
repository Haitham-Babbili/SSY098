function [mask, intersect] = get_cell_mask( img, position, radius, mask_size )
%GET_CELL_MASK Obtain mask for cells in a image with the given radius.
%   Input arguments:
%   - img : the given image
%   - position : the known positions of cells
%   - radius : the radius of centre region
%   - mask_size : the size of the mask of a patch, default value is 35
%   Outputs:
%   - mask : the region of the cell with given radius
%   - intersect : coarse interaction region of two cells
% Author: Qixun Qu

% Initialize the mask of a all-zero matrix
[rows, cols, ~] = size(img);
mask = zeros(rows, cols);

% Set cell centre pixel with 1 in mask
idx = sub2ind(size(img), position(2, :), position(1, :));
mask(idx) = 1;

% Generate a little mask, it has a white disk at its centre
mask_pos = - mask_size / 2 + 0.5 : mask_size / 2 - 0.5;
[x, y] = meshgrid(mask_pos);
circ = ((x.^2 + y.^2) <= radius^2);

% Filter the mask with the little mask,
% at the position where there should be a cell,
% a white disk appears
fg = imfilter(mask, double(circ));
% The cell region has values that larger than 0
mask = (fg > 0);

% The intersection resion has values larger than 1,
% since the intersection region is an override area of several disk
intersect = (fg > 1);

end