function result = gaussian_filter(img,std)

h = fspecial('gaussian',ceil(4*std),std);       % Size of filter at least 4*std
result = imfilter(img,h,'symmetric');           % Return filtered image

end
