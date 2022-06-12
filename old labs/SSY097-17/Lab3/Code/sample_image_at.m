function value = sample_image_at( img, position )
%SAMPLE_IMAGE_AT Extract the pixel value at the 'posotion' in the 'img'.
%   Input arguments:
%   - img : the source image which needs to be warped
%   - position : a vector contains the position of the interested pixel
%   Output:
%   - value : the pixel value at the positio in the input image

% Get the size of the image
[rows, cols, ~] = size(img);

% Get the nearest pixel if input position is not integer
position = round(position);

if position(1) < 1 || position(1) > rows || ...
   position(2) < 1 || position(2) > cols
    % If the position is out of the range of image,
    % set the returned value to 1
    value = 1;
else
    % else, return the real value
    value = img(position(1), position(2));
end

end