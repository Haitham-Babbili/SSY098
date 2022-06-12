function  filtered_img = gaussian_filter(img, st_dev);

% image_size=size(img);
gauss_filter= fspecial('gaussian', 4*st_dev, st_dev); % 2nd term act as filter aize value which is = 4*sigma


filtered_img = imfilter(img, gauss_filter, 'symmetric');


end

