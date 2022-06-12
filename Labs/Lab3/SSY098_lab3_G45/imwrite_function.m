function imwrite_function(image, path)
if exist(path, 'file')
    delete(path)
end
% save the image
imwrite(image,path)
end

