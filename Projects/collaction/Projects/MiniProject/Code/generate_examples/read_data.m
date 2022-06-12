function [ positions, images ] = read_data( folder )
%READ_DATA Read images and known positions of cells in a certain folder.
%   Input argument:
%   - folder : a path holds the data in format .mat and .png
%   Outputs:
%   - positions : known positions of cells in .mat file
%   - images : all given .png images in the folder
% Author: Qixun Qu

% Obtain all file names in the folder
% The concerned files are in format .mat and .png
mat_names = dir([folder '*.mat']);
pic_names = dir([folder '*.png']);

% Obtain the number of cases
case_num = length(mat_names);

% Initialize cells to keep outputs
positions = cell(case_num, 1);
images = cell(case_num, 1);

for i = 1 : case_num
    
    % Obtain the positions from .mat file
    load([folder mat_names(i).name], 'cells')
    positions{i} = round(cells);
    
    % Save image into the images cell
    images{i} = im2double(imread([folder pic_names(i).name]));
    
end

end