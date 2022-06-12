function patches = rotate_patch( img, posr, posc, pch_size, angle )
%%ROTATE_PATCH Get the patch around the cell centre, then rotate this patch
%in every 'angle' degree between 0 and 180. The zero-degree is the original
%patch.
%   Input arguments:
%   - img : the given image
%   - posr, posc : the positions of given cells' centre
%   - pch_size :  the size of the patch, here is 35 in this case
%   - angle : rotation angles for data augmentation
%   Output:
%   - patches : extract the nerghboring area of cell centre with a radius,
%     and then rotate it with several angles
% Author: Qixun Qu

% Compute the radius of each patch
pch_radius = (pch_size - 1) / 2;

% Double the radius to get a larger patch ,
% rotate this larger path, the wanted patch is
% the subset of it
l_pch_radius = pch_radius * 2;

% Get all angles that the larger patch will rotate
angles = 0 : angle : 180;
% Get the number of angles
angles_num = length(angles);

% Pad the image with the latger radius
% The padding part is symmetric as the boundary region of image
pad_img = padarray(img, [l_pch_radius l_pch_radius], 'symmetric');

% Reset the positions of cell centre since the image has been padded
posr = posr + l_pch_radius;
posc = posc + l_pch_radius;

% Initialize the cell to hold all patches
pts_num = length(posc);
patches = cell(1, pts_num * angles_num);

for i = 1 : pts_num

    % Get the larger patch at each point of cell centre
    temp = pad_img(posr(i) - l_pch_radius : posr(i) + l_pch_radius, ...
                   posc(i) - l_pch_radius : posc(i) + l_pch_radius, :);

    for j = 1 : angles_num
        % Rotate larger patch with different angles
        temp_rt = imrotate(temp, angles(j), 'bilinear');
        
        % Obtain the center of the rotate patch
        c = round((length(temp_rt) + 1) / 2);
        
        % Extract the subset of the larger patch as the
        % result of one rotation, put it into the cell
        patches{angles_num * (i - 1) + j} = ...
                temp_rt(c - pch_radius : c + pch_radius, ...
                        c - pch_radius : c + pch_radius, :);
                    
    end

end

end