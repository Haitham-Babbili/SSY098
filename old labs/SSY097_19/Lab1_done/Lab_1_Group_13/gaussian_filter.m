function  filtered_img = gaussian_filter(img, dev);
% - INPUT
% A greyscale image, standard deviation (filter size = 4*standard
% deviation)
% 
% - OUTPUT
% A filtered (gaussian) image with 
% 
% Function takes a gray image and filters it with a gaussian filter with
% a filtersize of 4*deviation. the input image need to be gray 

% constructs a lowpass gaussian 2-d filter with 4* the size of the wanted
% deviation 
h_size=size(img);
gauss_filter= fspecial('gaussian', h_size, dev);

% filters the input image with the gaussian fiter, image is padded with
% mirroring
filtered_img = imfilter(img, gauss_filter, 'symmetric');

end

