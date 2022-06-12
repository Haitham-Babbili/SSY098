function [grad_x, grad_y] = gaussian_gradients(img, std) 
% - INPUT
% A greyscale image, standard deviation (to be used in gaussian_filter)
% 
% - OUTPUT
% Two matrixes, [x y], containing the gradient in x- respectivle
% y-direction. Both are same size as input image
% 
% inputimage must be grayscale 
% function reads an image and a set deviation, outputs the color gradients
% in x & y coordinates

img_gaussian= gaussian_filter(img,std); 


[grad_x, grad_y] = gradient(img_gaussian) ;


end

