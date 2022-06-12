function cell_neighbor = get_cell_neighbor( rough )
%GET_CELL_BEIGHBOR Get the neighborhood region of cells.
%   Input argument:
%   - rough : rough cell body
%   Output:
%   - cell_neighbor : a mask for the neighbor region of cells
% Author: Qixun Qu

% Generate two kernals with different size
se = cell(2, 1);
se{1} = strel('disk', 5);
se{2} = strel('disk', 3);

for i = 1 : 2
    
    % First dilate the rough cell region,
    % the region becomes larger, the neighbor area among cells
    % may be filled by 1
    temp_img = imdilate(rough, se{i});
    % Then, erode the larger region, but nerghbor area among several
    % cells is kept
    temp_img = imerode(temp_img, se{i});
    
end

% Remove rough cell region from the larger region
cell_neighbor = temp_img - rough;

end