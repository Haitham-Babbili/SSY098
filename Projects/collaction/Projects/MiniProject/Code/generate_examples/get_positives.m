function [ examples, labels ] = get_positives(images, masks, pch_size, angle, colors)
%%GET_POSITIVES Generate positive examples for training and validation set.
%   Input arguments:
%   - images : a cell contains training images or validation images
%   - masks : a cell has masks for all given images
%   - pch_size : the size of the patch, here is 35 in this case
%   - angle : rotation angles for data augmentation
%   - colors : color-modified patch for data augmentation
%   Output:
%   - examples : the positive patches generated from all given images
%   - labels : labels for patches, here all elements are 6
% Author: Qixun Qu

% Initialize the cell to keep all patches
examples = {};

% Obtian the number of given images
img_num = length(images);

h = waitbar(0, 'Generating Positives Examples ...');
for idx = 1 : img_num

    waitbar(idx / img_num)
    
    % Obtain a certain image anf its mask
    img = images{idx};
    mask = masks{idx};
    
    % Find positions for all given cell centre
    [posr, posc] = find(mask == 6);

    % Get the patch around the cell centre,
    % then rotate this patch in every 'angle' degree between 0 and 180
    patches = rotate_patch(img, posr, posc, pch_size, angle);
    
    % Obtain the color-modified patch for each patch
    % in previous step
    patches = modify_patch_color(patches, colors);
    
    % Form the patches cell
    examples = [examples, patches];
    
end
close(h)

% Generate labels for all patch
labels = ones(1, length(examples)) * 6;

end