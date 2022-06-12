function plot_examples( examples, labels, num )
%PLOT_EXAMPLES Plot several positive and negative examples.
%   Input arguments:
%   - examples : training data contains training images
%   - labels : the real label for each training image
%   - num : the number of images in each row of plot

% Set the default value of num
if nargin < 3
    num = 5;
end

% Obtain positions in traing set of positive examples
% and negative examples
posi_pos = find(labels == 1);
nega_pos = find(labels == 0);

% Obtain the size of training image
[img_r, img_c, ~] = size(examples{1});

% Extract first num^2 training images of positive
% and negative examples
posi_pos = posi_pos(1:num^2);
nega_pos = nega_pos(1:num^2);

% Initialize two matrix to combine example images
% into two larger images
posi_lg = zeros(img_r*num, img_c*num, 3);
nega_lg = zeros(img_r*num, img_c*num, 3);

for i = 1 : num^2
    
    % Calculate positions of each example in
    % combination matrix
    if mod(i, num) == 0
        row = i / num;
        col = num;
    else
        row = floor(i / num) + 1;
        col = mod(i, num);
    end

    % Place example image in the comnination matrix
    posi_lg((row-1)*img_r+1:img_r*row, (col-1)*img_c+1:img_c*col, :) = ...
        examples{posi_pos(i)};
    nega_lg((row-1)*img_r+1:img_r*row, (col-1)*img_c+1:img_c*col, :) = ...
        examples{nega_pos(i)};
    
end

% Plot two combination matrix
figure
set(gcf, 'Position', [200 200 1000 400]);
subplot(1, 2, 1)
imagesc(posi_lg), axis off
subplot(1, 2, 2)
imagesc(nega_lg), axis off

end

