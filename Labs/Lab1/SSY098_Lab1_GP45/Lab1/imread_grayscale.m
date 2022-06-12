function [read_file]= imread_grayscale(path)
% % This function is to use grayscle image for the excercise, 
% as against coloured image
%- INPUT INFORMATION
% The path to the image file given
% 
% - OUTPUT INFORMATION
% The grayscaled image of the original image

given_image=imread(path);
imreaddouble = im2double(given_image);
read_file=mean(imreaddouble,3);
% 

end

