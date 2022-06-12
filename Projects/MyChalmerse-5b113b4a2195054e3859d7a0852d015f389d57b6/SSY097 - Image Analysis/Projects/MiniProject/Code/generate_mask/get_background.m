function pure_backgrd = get_background( goal_cells, nongoal_cells )
%GET_PURE_BACKGROUND Obtain the pure background of given image. The pure
%background is the region which has any cells in it.
%   Input argument:
%   - goal_cells : the interested cells in the image
%   - nongoal_cells : the non-target cells in the image
%   Output:
%   - pure_background : a mask for the region that has any cells
% Author: Qixun Qu

% Obtain all cell objects in the mask
all_obj = goal_cells + nongoal_cells;
all_obj(all_obj > 1) = 1;

% Incerse the mask to get pure background
pure_backgrd = 1 - all_obj;

end