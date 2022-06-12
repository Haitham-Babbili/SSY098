function [grad_x, grad_y]=gaussian_gradients(img,std)
filtered=gaussian_filter(img,std);
% then take the 'laplacian of the image'
[grad_x, grad_y]=gradient(filtered);
end