function plot_object_squares( image, obj_pos )
%PLOT_OBJECT_SQUARES Plot nine small squares in full scale image.
%   Input arguments:
%   - image : the full scale image that will be plotted nine squares in
%   - obj_pos : a n x 3 matrix, first two columns store the position of the
%   patch's center, the third column stores the scale of the patch
% Author: Qixun Qu

% Generate a new figure, plot the full scale image first
figure
imagesc(image), colormap gray
axis image, axis off
hold on

% Obtain the number of patches, all patches are about to be segmented in
% nine samll squares and also be plotted in full scale image
obj_num = size(obj_pos, 1);

for i = 1 : obj_num
    
    % For each patch, calculate the nine centers of samll squares and the
    % radius as well, plotting all nine squares in full scale image
    [centres, redius] = place_regions(obj_pos(i, 1:2), obj_pos(i, 3));
    plot_squares(image, centres, redius)
    
end

hold off

end

