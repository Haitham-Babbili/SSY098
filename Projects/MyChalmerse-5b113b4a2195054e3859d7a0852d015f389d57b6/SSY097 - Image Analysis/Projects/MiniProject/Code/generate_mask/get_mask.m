function img_mask = get_mask( img, position, radius, edge )
%GET_IMAGE_MASK Obtian the mask image for the given image.
%   Input arguments:
%   - img : the given image needs to generate mask for
%   - position : the known positions for all cells in the image
%   - radius : the radius of cell centre
%   - edge : the distance between cell centre to its edge
%   Output:
%   - img_mask : the mask for the image, seven parts in the mask:
%     1. cell centre
%     2. unuesed pixel, the region around the centre to make sure
%        thers is a distance between positive examples and negative ones
%     3. cell edge, the edge region of cells
%     4. intersect, the intersection of two cells
%     5. cell neighbor area, the region between two or several cells
%     6. non-goal cells
%     7. pure background
%     In a mask, each part has its own value:
%     Part             |   Value
%     -----------------|---------
%     Unused value     |     0
%     intersection     |     1
%     non-goal cells   |     2
%     cell edge        |     3
%     cell neighbor    |     4
%     pure background  |     5
%     cell centre      |     6
%     -----------------|---------
% Author: Qixun Qu

% Obtain cell centre, rough cell body and
% coarse interaction region of two cells
[centre_cell, rough_cell, rough_intsct] = ...
                 get_goals_cell(img, position, radius);

% Obtain nongoals cells
nongoals_cell = get_nongoals_cell(img, position);

% Obtain pure background
pure_backgrd = get_background(rough_cell, nongoals_cell);

% Obtain the skeleton of intersect region
intsct_skel = get_cell_intersect(img, position, rough_intsct);

% Obtain edge of cells
l_radius = radius + edge;
cell_edge = get_cell_edge(img, position, rough_cell, ...
                          intsct_skel, l_radius);

% Get common neighbor area of several cells
cell_neighbor = get_cell_neighbor(rough_cell);

% Initialize the mask for whole image
[rows, cols, ~] = size(img);
img_mask = zeros(rows, cols);

% Set values for different part
img_mask(pure_backgrd == 1)  = 5;
img_mask(intsct_skel == 1)   = 1;
img_mask(nongoals_cell == 1) = 2;
img_mask(cell_edge == 1)     = 3;
img_mask(cell_neighbor == 1) = 4;
img_mask(centre_cell == 1)   = 6;

end