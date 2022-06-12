function [ examples, labels ] = get_negatives(images, masks, pch_size, angle, colors)
%%GET_NEGATIVES Generate the negative examples for training and valifdation
%set.
%   Input arguments:
%   - images : a cell contains training images or validation images
%   - masks : a cell has masks for all given images
%   - pch_size : the size of the patch, here is 35 in this case
%   - angle : rotation angles for data augmentation
%   - colors : color-modified patch for data augmentation
%   Output:
%   - examples : the negative patches generated from all given images
%   - labels : labels for patches, here elements have 5 values from 1 to 5
% Author: Qixun Qu

% Initialize the return variables
examples = {};
labels = [];

% Get the number of given images
img_num = length(images);

% Since there are much more negative cases can be generated
% from image than positive ones, the data augmentation will
% not be carrid out on the negative patches
% To make sure the number of negatives and positives are roughly
% equal, it is necessary to comput how many times that negative
% examples as much as the given position of cells
times = (floor(180 / angle) + 1) * (colors + 1);

% Obtain the patch radius
pch_radius = (pch_size - 1) / 2;

h = waitbar(0, 'Generating Negative Examples ...');
for i = 1 : img_num

    waitbar(i / img_num)
    
    % Obtain the mask for one image
    mask = masks{i};
    
    % First, comput the number of negatives to be generated
    % from one image
    patch_num = times * length(find(mask == 6));
    
    % Get all positions where the negative patches will be extracted
    % and the corresponding labels as well
    [posr, posc, labels_each] = get_negative_pos(mask, patch_num);
    
    % The padding part is symmetric as the boundary region of image
    pad_img = padarray(images{i}, [pch_radius pch_radius], 'symmetric');
    
    % Reset the patch centre since the image has been padded
    posr = posr + pch_radius;
    posc = posc + pch_radius;
    
    % Initialize the cell to hold patches of one image
    patch_num = length(posr);
    patches = cell(1, patch_num);

    for j = 1 : patch_num
        
        % Extract all patches from one image
        patches{j} = pad_img(posr(j) - pch_radius : posr(j) + pch_radius, ...
                             posc(j) - pch_radius : posc(j) + pch_radius, :);
    
    end
    
    % Put patches into the cell
    examples = [examples, patches];
    
    % Put the labels into the vector
    labels = [labels, labels_each];
    
end
close(h)

end