function [grad_x, grad_y] = gaussian_gradients(img, std)

blurimg = gaussian_filter(img, std);

[grad_x, grad_y] = gradient(blurimg);