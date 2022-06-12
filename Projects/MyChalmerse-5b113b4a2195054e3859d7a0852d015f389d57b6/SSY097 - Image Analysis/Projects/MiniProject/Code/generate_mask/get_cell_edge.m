function cell_edge = get_cell_edge(img, position, rough, intsct, edge)
%GET_CELL_EDGE Obtain the edge region of cells.
%   Input arguments:
%   - img : the given image
%   - position : the known positions of cells
%   - rough : rough cell body
%   - intsct : the skeleton of intersection of cells
%   - edge : the distance between cell centre and its edge, default is 5
%   Output:
%   - cell_edge : a mask for the region of cell edge
% Author: Qixun Qu

% Set the default value
if nargin < 5
    edge = 5;
end

% Get a bigger centre region of cells than before
big_centre_cell = get_goals_cell(img, position, edge);

% Obtaib the edge resion by removing the bigger centre region
% from rough cell region
cell_edge = rough - big_centre_cell;

% From the edge region, remove the pixels that override
% with intersection skeleton
cell_edge = ((cell_edge == intsct) < cell_edge);

end