function detection = run_detector( img )
%RUN_DETECTOR This function is used to detecte cells in gigen image with
%the trained model.
%   Input argument:
%   - img : the image to be detected
%   Outputs:
%   - detection : the positions of each detected cell

% Load the trained model
load 'cell_net.mat'

% Set the patch radius
patch_radius = 17;

% Get the classification result, 'out' is a n x m x 6 matrix,
% each pixel has 6 probabilities for six class,
% the highest one indicates which class this point belongs to
out = apply_exhaustive(net, img, patch_radius);

% Initialize the result to hold calssifition result
% for each pixel in the probability map
[rows, cols, ~] = size(img);
result = zeros(rows, cols);

for i = 1 : rows
    for j = 1 : cols
        
        % Find the highest probability and
        % set the class to one pixel
        temp = out(i, j, :);
        result(i, j) = find(temp == max(temp));
        
    end
end

% An optimazation for false detected cell
% Obtain a mask for the non-goal cells in classification result
nongoals = (result == 2);
% Fill the holes of non-gola regions,
% since if a region is classified as cell region but it is surrounded by
% non-goals point, this case will be regarded as false detected cell and it
% will be removed
nongoals = imfill(nongoals, 'holes') * 2;
result(nongoals > 0 & result ~= nongoals) = 2;

% Get all positions od non-goal points
nong_pos = find(result == 2);

% Plot the classification mask, the plot is a kind of
% roughly segmentation for cells and some other objects
plot_image_mask(result)

% Obtain the probability of each pixel which is the probability
% that the pixel is a cell point
prob = out(:,:,6);

% Carry out the strict local maximum method
filter = fspecial('gaussian', [7, 7], 2);
prob_filt = imfilter(prob, filter, 'symmetric');

max_filt = ordfilt2(prob_filt, 8, ones(3));
[cell_rows, cell_cols] = find(prob_filt > max_filt & prob > 0.7);

% Form the output which consists of all positions
% of detected cells
detection = [cell_rows'; cell_cols'];

% Some of the detected cells maybe the false one,
% remove it form the detection
for i = length(cell_rows) : -1 : 1

    ng_num = length(find(nong_pos == (cell_cols(i)-1)*rows+cell_rows(i)));
    if  ng_num ~= 0
        detection(:, i) = [];
    end

end

% Plot result in the given image
figure
set(gcf, 'Position', [200, 200, 800, 500])
image(img), axis off
hold on
plot(detection(2, :), detection(1, :), 'g*')

end