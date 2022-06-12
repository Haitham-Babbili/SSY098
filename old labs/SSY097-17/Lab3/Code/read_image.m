function img = read_image( path )
%READ_IMAGE Read image from path and convert the values into the range of
%0 to 1.
%   Input argument:
%   - path : the image path
%   Output:
%   - img : am image in 'double' values

% Read image from path
img = imread(path);

% Convert image to 'double'
img = im2double(img);

end