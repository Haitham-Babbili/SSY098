function test_set = struct_testset( obj_pos, obj_num, real_labels )
%STRUCT_TESTSET Struct a testset that consists of all centers' position and
%scale size of patches, each patche has one digit that is obtaines from
%function get_objects() in previous step.
%   Input arguments:
%   - obj_pos : a n x 3 matrix, first two columns store the position of the
%   patch's center, the third column stores the scale of the patch
%   - obj_num : the amount of objects (patches) in full scale image
%   - real_labels : a number shows which digit the patch has
%   Outputs:
%   - test_set : there are three variables in test set, which are position 
%   of each patch's center, scale size of each patch and the true label 
%   that indicates the digit in the patch; in this function, no new values
%   are generated.
% Author: Qixun Qu

% Initialize the structure of test set, 
test_set = struct('position', [], 'scale', [], 'label', []);

for i = 1 : obj_num
    
    % Put information in each object in the test set
    test_set(i).position = obj_pos(i, 1:2);
    test_set(i).scale = obj_pos(i, 3);
    test_set(i).label = real_labels(i);
    
end

end

