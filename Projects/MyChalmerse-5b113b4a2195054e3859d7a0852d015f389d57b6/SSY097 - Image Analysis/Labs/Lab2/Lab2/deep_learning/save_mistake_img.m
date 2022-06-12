function save_mistake_img( predict, data, num )
%SAVE_MISTAKE_IMG Save several (3 in default) mistaken images which are
%faliures in predicted result into a folder.
%   Input arguments:
%   - predict : a vector contains predicted labels
%   - data : a data set has real labels
%   - num : the number of mistaken images need to be saved, 3 in default
% Author: Qixun Qu

% Set the default value for num
if nargin < 3
    num = 3;
end

% Alphabet contains all 26 characters
alphabet = 'abcdefghijklmnopqrstuvwxyz';

% Obtain the position of mistaken results 
mistake_no = find(predict ~= data.labels);

% Randomly select num positions from mistaken results
random_pos = randi(length(mistake_no), num, 1);

% Obtain the index of these mistaken results
mistake_idx = mistake_no(random_pos);

for i = 1 : num
    
    % Get the label of the mistaken result
    no = data.labels(mistake_idx(i));
    % Save image into a folder
    imwrite(data.imgs{mistake_idx(i)}, ...
            ['Results\mistaken_as_' alphabet(no) '.png'])
    
end

end