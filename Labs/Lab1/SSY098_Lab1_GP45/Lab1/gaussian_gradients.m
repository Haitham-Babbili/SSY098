function [grad_x, grad_y] = gaussian_gradients(img, std)
% - INPUT
% A grayscale image and standard deviation (to be used in gaussian_filter)
% 
% - OUTPUT
% Two matrixes, [x y], containing the gradient in x- respectivle
% y-direction. Both are same size as input image

% This is needed to get scale-invariant features of the given image


result= gaussian_filter(img,std); 


[grad_x, grad_y] = gradient(result) ;

end

