function plot_image_mask( image_mask, mode )
%PLOT_IMAGE_MASK Plot the given mask for an image.
%   Input argument:
%   - image_mask : the mask of one image
%   - mode : if mode is 0, the input mask is generated from training images
%     set or validation image set; if mode is 1, the input mask is the
%     result of classification, the default value for mode is 0
% Author: Qixun Qu

% Set the default value for mode
if nargin < 2
    mode = 0;
end

% Set the color map for the output image
cmp = colormap(lines(7));

% Get how many different values in the mask
color_num = length(unique(image_mask));

% Plot mask
figure
set(gcf, 'Position', get(0, 'ScreenSize'))
imagesc(image_mask), colormap(cmp(8-color_num:7, :))
set(gca, 'FontSize', 12)

if mode == 0
    % Color bar for training or validating mask
    colorbar('Ticks', [0.4 1.25 2.15 3 3.85 4.7, 5.55], ...
             'TickLabels', {'Unused Pixels', 'Intersect', ...
                            'Non-goals Cells', 'Cell Edge', ...
                            'Cell Neighbor', 'Background', ...
                            'Cell Centre',})
elseif mode == 1
    % Color bar for testing mask
    colorbar('Ticks', [1.4 2.2 3.1 3.9 4.75 5.55], ...
             'TickLabels', {'Intersect', 'Non-goals Cells', ...
                            'Cell Edge', 'Cell Neighbor', ...
                            'Background', 'Cell Centre',})
else
    error('Wrong mode, 0 for training and validating, 1 for testing.')
end
axis off

end