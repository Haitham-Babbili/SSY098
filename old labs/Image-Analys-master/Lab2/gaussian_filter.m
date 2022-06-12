function result = gaussian_filter(img, SIGMA)

ISIZE = size(img);
HSIZE = [ISIZE(1), ISIZE(2)];
h = fspecial('gaussian', HSIZE, SIGMA);

result = imfilter(img, h, 'symmetric');