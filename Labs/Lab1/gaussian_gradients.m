function [grad_x, grad_y] = gaussian_gradients(img, std)



gauss_img= gaussian_filter(img,std); 


[grad_x, grad_y] = gradient(gauss_img) ;

end

