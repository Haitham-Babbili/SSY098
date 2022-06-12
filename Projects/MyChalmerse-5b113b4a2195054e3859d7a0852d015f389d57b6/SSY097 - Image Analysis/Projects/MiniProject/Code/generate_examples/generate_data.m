function data = generate_data( folder, pch_size, angle, colors, radius, edge )
%GENERATE_DATA This function is used to generate training set and
%validation set to train the network.
%   Input arguments:
%   - folder : the folder consists of training images and validating images
%   - pch_size : the size of the patch, here is 35 in this case
%   - angle : rotation angles for data augmentation
%     all angles = 0 : angle : 180
%     if angle > 180, original patch will not be rotated
%   - colors : color-modified patch for data augmentation,
%     2 more images will be generated from each patrch
%   - radius : cell centre radius
%     if radius = 0, only the centre points are marked
%   - edge : the distance between cell centre to its edge
%     the region between centre and edge will not extract
%     either positive examples or negative examples
%   Output:
%   - data : d dataset contains patches and corresponding label
% Author: Qixun Qu

% Read all images from a certain folder
[positions, images] = read_data( folder );

% Obtain the number of images
case_num = length(images);

% Initialize a cell to hold masks for all images
images_mask = cell(case_num, 1);

for i = 1 : case_num
    
    % Obtain mask for each image
    images_mask{i} = get_mask(images{i}, positions{i}, radius, edge);
    
end

% Generating positive examples and their labels
[positives, labels_p] = ...
    get_positives(images, images_mask, pch_size, angle, colors);

% Generating negative examples and their labels
[negatives, labels_n] = ...
    get_negatives(images, images_mask, pch_size, angle, colors);

% Pool positive examples and negative examples into a cell
examples = [positives, negatives];

% Poos labels for both examples 
labels = [labels_p, labels_n];

% Form a struce with variable names as 'example' and 'label'
data.example = examples;
data.label = labels;

end