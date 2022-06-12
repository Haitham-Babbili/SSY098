function [ imgdouble ] = imread_colour(path_to_file)
% This function is to use coloured image for the excercise, 
% as against grayscale
% - INPUT INFORMATION
% The path to image file given
% 
% - OUTPUT INFORMATION
% Coloured Image

given_image=imread(path_to_file); 
imgdouble=im2double(given_image);
% 
end

