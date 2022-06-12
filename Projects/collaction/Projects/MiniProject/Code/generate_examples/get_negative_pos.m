function [ posr, posc, labels ] = get_negative_pos( mask, each_num )
%%GET_NEGATIVE_POS Generate the positions where the negative patches are
%extracted.
%   Input arguments:
%   - mask : the mask for one image
%   - each_num : the nnumber of positions to be generated
%   Outputs:
%   - posr, posc : the position of each negative patch
%   - labels : a vector consists of labels for each patch
% Author: Qixun Qu

% Initialize the return variables
posr = [];
posc = [];
labels = [];

% In this case, 5 types negative examples will be extracted
for i = 1 : 5
    
    % Catch all points of ith negative examples in one mask
    [tempr, tempc] = find(mask == i);
    temp_num = length(tempr);
    
    % per_num is the number of negative examples that should be created
    per_num = each_num;
    
    if 0 < temp_num && temp_num < per_num
        % If the number of negative examples in one mask is smaller
        % than what it should be, use the smaller value as the number
        % of negatives
        per_num = temp_num;
    elseif temp_num == 0
        continue
    end
    
    % Randomly selecte some points from all positions of
    % negative examples
    rnd_i = randperm(temp_num, per_num);
    posr = [posr; tempr(rnd_i)];
    posc = [posc; tempc(rnd_i)];
    
    % Set the label for the ith type negatives
    labels = [labels, ones(1, per_num)*i];
    
end

end