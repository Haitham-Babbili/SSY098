function img = modify_a_color( img )
%%MODIFY_A_COLOR Modify the color of one image.
%   Input arguments:
%   - img : the image to be modified
%   Output:
%   - img : the color-modified image
% Author: Qixun Qu

% Convert the image to hsv model
img = rgb2hsv(img);

% Obtain each channel of image
hue = img(:, :, 1);
sat = img(:, :, 2);
int = img(:, :, 3);

% Generate a random change for
% each channel, the range is -5 to 5
h = randi(10) - 5;
s = randi(10) - 5;
v = randi(10) - 5;

% Modify each channel of image
hue = hue + 1 / 360 * h;
sat = sat + 0.01 * s;
int = int + 0.01 * v;

% Rerange each channel, make sure that
% the value of each channel is from 0 to 1
hue(hue > 1) = 1; hue(hue < 0) = 0;
sat(sat > 1) = 1; sat(sat < 0) = 0;
int(int > 1) = 1; int(int < 0) = 0;

% Reform the image
img(:,:,1) = hue;
img(:,:,2) = sat;
img(:,:,3) = int;

% Convert image from hsv to rgb model
img = hsv2rgb(img);
    
end