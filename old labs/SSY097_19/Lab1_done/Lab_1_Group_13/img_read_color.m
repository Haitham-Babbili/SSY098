function [ imgdouble ] = img_read_color(path_to_file)
% - INPUT 
% patch to image
% 
% - OUTPUT
% image in color

raw_image=imread(path_to_file); 
imgdouble=im2double(raw_image);
% imagesc(imgdouble)
end

