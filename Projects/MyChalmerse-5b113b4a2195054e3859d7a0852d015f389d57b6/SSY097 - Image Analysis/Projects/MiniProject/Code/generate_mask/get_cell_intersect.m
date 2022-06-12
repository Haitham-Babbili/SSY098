function intsct_skel = get_cell_intersect( img, position, intersect )
%GET_EXACT_INTERSECT Obtain the skeleton of intersection region of several
%cells.
%   Input arguments:
%   - img : the given image
%   - position : the known positions of cells
%   - intersect : coarse interaction region of two cells
%   Output:
%   - intsct_skel : a mask contains the skeleton of intersection region
% Author: Qixun Qu

% Obtain the skeleton from coarse interaction region
skel = bwmorph(intersect, 'skel', Inf);

% Obtain the mask for the centre area of cells
centre = get_goals_cell(img, position);

% Remove the override points that appears in both cell centres
% and intersection skeleton from the skeleton mask
intsct_skel = ((centre == skel) < skel);

end