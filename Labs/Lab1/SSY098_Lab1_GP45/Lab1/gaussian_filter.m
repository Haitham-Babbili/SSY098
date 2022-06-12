function  filtered_img = gaussian_filter(img, std);

% - INPUT
% Creation of a low-pass Gaussian Filter
% A grayscale image, standard deviation 
% Instructed to make filter size = 4* standard deviation (std)
% 
% - OUTPUT
% A filtered (gaussian) image
%
gauss_filter= fspecial('gaussian', 4*std, std);
 % The 2nd term act as filter size value which is = 4*sigma

 % Below gives the final filtered image
filtered_img = imfilter(img, gauss_filter, 'symmetric');


end

