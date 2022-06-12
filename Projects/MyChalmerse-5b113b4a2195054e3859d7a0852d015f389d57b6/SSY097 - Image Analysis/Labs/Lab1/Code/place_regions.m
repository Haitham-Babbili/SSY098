function [ region_centres, region_radius ] = place_regions( centre, scale )
%PLACE_REGIONS Return center's position and radius of each small square of a
%patch. Center's position indicates the coordinate of each small square in
%the full scale image.
%   Input arguments:
%   - centre : position of the patch's center in full scale image
%   - scale  : the size of the patch
%   Outputs:
%   - region_centres : 2 x 9 matrix records nine centers of 9 small squares
%   - region_redius  : a number show the radius of each small square
%
%   Input arguments and outputs could be shown as below
%   |<---- scale ---->|
%   |-----|-----|-----|----|--> region_redius
%   |  *  |  *  |  *  |----|
%   |-----|-----|-----|         X : centre
%   |  *  |  X  |  *  |
%   |-----|-----|-----|         * & X : region_centres
%   |  *  |  *  |  *  |
%   |-----|-----|-----|
% Author: Qixun Qu

% Calculate radius for each small square
% (scale - 3) : since the center is not a part of radius, each row and
% each column of patch consists of 6 radius and 3 centers
% using function floor() is trying to ensure that the edge of image will
% not be exceeded in the follwing operation
region_radius = floor((scale - 3) / 6);

% Set the relative center position, the relative center is the center in
% the patch, not in the full scale image
c = 3 * region_radius + 2;
rc = [c, c];

% Set three numbers that can form all nine centers' position
% all centers (except the midpoint) converge 1 pixel to the midpoint to
% prepare for the overlap
c_pos = [c - 2 * region_radius, c, c + 2 * region_radius];
[x, y] = meshgrid(c_pos);

% Calculate the distance between each center of samll squrae and the
% relative center of the patch
dis = bsxfun(@minus, [x(:)'; y(:)'], rc');
% Calculate the real position of each small square in full scale image
region_centres = bsxfun(@plus, dis, centre');

% Now, radius pluses 1 that achives 2-pixel overlap
region_radius = region_radius + 1;

end

