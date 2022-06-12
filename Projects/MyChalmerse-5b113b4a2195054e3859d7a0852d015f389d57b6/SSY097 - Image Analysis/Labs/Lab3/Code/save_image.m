function save_image( image, path )
%SAVE_IMAGE Save image into the given path.
%   Input arguments:
%   - image : the image that needs to be saved
%   - path : the path that the image will be saved in
% Author: Qixun Qu

% If the text file is already existed, delete it
if exist(path, 'file')
    delete(path)
end

% Save the image
imwrite(image, path)

end