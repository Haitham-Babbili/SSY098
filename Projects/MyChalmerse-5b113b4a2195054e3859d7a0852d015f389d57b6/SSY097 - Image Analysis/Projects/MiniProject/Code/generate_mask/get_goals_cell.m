function [ centre_cell, rough_cell, cell_intsct ] = ...
    get_goals_cell( img, position, radius, l_radius, mask_size )
%GET_GOALS_CELL Return cell centre, rough cell body and coarse interaction
%   region of two cells.
%   Input arguments:
%   - img : the given image
%   - position : the known positions of cells
%   - radius : the radius of centre region in a cell, default value is 5
%   - l_radius : a larger radius of a region that the cell is contained in,
%     default value is 11
%   - mask_size : the size of the mask of a patch, default value is 35
%   Outputs:
%   - centre_cell : the centre region of the cell
%   - rough_cell : rough cell body
%   - cell_intsct : coarse interaction region of two cells
% Author: Qixun Qu

% Set default values
if nargin < 5
    mask_size = 35;
end

if nargin < 4
    l_radius = 11;
end

if nargin < 3
    radius = 5;
end

% Obtain rough cell region and cell intersection
[rough_cell, cell_intsct] = ...
              get_cell_mask(img, position, l_radius, mask_size);
          
% Obtain the centre area of cells
centre_cell = get_cell_mask(img, position, radius, mask_size);

end