function patches_all = modify_patch_color( patches, colors )
%%MODIFY_PATCH_COLOR Generate severalnew patches by modifying the color of
%each patch.
%   Input arguments:
%   - patches : a cell consists of many patches that has been generated in
%     precious step
%   - colors : the number of color-modified patch for each example
%   Output:
%   - patches_all : a cell contains all patches in positive set
% Author: Qixun Qu

% Initialize the cell to hold all patches
patch_num = length(patches);
patches_all = cell(1, colors * patch_num);

for i = 1 : patch_num

    % First, put the original patch into the cell
    patches_all{(colors+1)*(i-1)+1} = patches{i};

    for j = 1 : colors

        % For each patch, generate color-modified patches,
        % and put them into the cell
        patches_all{(colors+1)*(i-1)+1+j} = ...
                     modify_a_color(patches{i});

    end

end
    
end