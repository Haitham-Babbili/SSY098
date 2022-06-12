function [ obj_pos, obj_num ] = get_objects( image )
%GET_OBJECTS Get all objects' positions in full scale image and the scale
%size of each object, here the objects are digits in the image.
%   Input arguments:
%   - image : a full scale image that has been binarized in previous step
%   Outputs:
%   - obj_pos : n x 3 matrix, n is the number of objects, first two columns
%   store position of each object's center, the third column stores the
%   scale size of the object
%   - obj_num : return the amount of objects
% Author: Qixun Qu

% Find all objects in binarizd image
% L is a matrix with background in 0,
% the first object in L is padded by the number 1,
% the second object in L is padded by the number 2,
% ......
% the nth object in L is padded by the number n
% obj_num : the amount of objects found in image
[L, obj_num] = bwlabel(image, 4);

% Initialize a matrix to store the position and scale size of each object
obj_pos = zeros(obj_num, 3);

for i = 1 : obj_num

    % Get all points of ith object
    [rows, cols] = find(L == i);
    rmx = max(rows); % -----|---> Get the range in y direction
    rmn = min(rows); % -----|
    cmx = max(cols); % -----|---> Get the range in x direction
    cmn = min(cols); % -----|
    
    % Get the max value between the height and the width of object
    % the larger one is the width of the square patch for object
    dmx = max([rmx - rmn, cmx - cmn]);
    
    % Calculate position and scale size for each object
    % the width of the patch times a constant to enlarge the size of the
    % patch
    obj_pos(i, :) = [round((cmx + cmn)/2),...
                     round((rmx + rmn)/2),...
                     round(1.3 * dmx)];
                 
end

end

