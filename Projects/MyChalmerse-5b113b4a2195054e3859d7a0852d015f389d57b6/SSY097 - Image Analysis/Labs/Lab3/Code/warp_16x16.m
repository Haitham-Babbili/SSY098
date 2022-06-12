function warped = warp_16x16( source )
%WARP_16X16 Warp a small image whose size is 16x16 by given transform
%coordinates.
%   Input argument:
%   - source : the original image that needs to be warped
%   Output:
%   - warped : the warped image
% Author: Qixun Qu

% Obtain the size of source image
[y_num, x_num, ~] = size(source);

% Initialize the warped image
warped = zeros(y_num, x_num);

for i = 1 : x_num
    for j = 1 : y_num
        
        % Traverse each point of warped image, find the
        % corresponding point in source image coordinate
        pos = transform_coordinates([i, j]);
        % Extract value from source image and put it into warped image
        % this process is carried out under matrix coordinate
        warped(j, i) = sample_image_at(source, [pos(2), pos(1)]);
        
    end
end

end