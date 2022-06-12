function patch = get_patch( image, x, y, patch_radius )
%GET_PATCH Get particial image at the center of (x, y) with the radius.
%   Input auguments:
%   - image : a full scalue image contains the wanted patch
%   - x, y  : position of the patch's center in full scale image
%   - patch_radius : the distance between patch's center and patch's edge
%   Output:
%   - patch : a square image with the width of (2 * patch_radius + 1)
% Author: Qixun Qu

% Get image height and width.
[height, width, ~] = size(image);

if x + patch_radius > width || x - patch_radius < 1
    % Edge of patch is out of the range of image in x direction
    error('Patch outside image borders in x direction.')
elseif y + patch_radius > height || y - patch_radius < 1
    % Edge of patch is out of the range of image in y direction
    error('Patch outside image borders in y direction.')
else
    % Extract particial image from full scale image
    patch = image(y-patch_radius : y+patch_radius,...
                  x-patch_radius : x+patch_radius);
end

end