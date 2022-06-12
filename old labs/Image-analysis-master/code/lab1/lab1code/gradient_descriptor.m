function desc=gradient_descriptor(image,position,radius)
histogram=zeros(72,1);
% divide up space around position into regions
centres=place_regions(position,radius);
% loop over regions
for i=1:8
patch=get_patch(image,centres(1,i),centres(2,i),radius);

% compute gaussian gradients with std prop. to radius
% std=(1/10)*radius is chosen to get a good approx after empirical tests
[grad_x,grad_y]=gaussian_gradients(patch,ceil(radius./10));

% compute histograms for the region and put into vector
histogram(i*9-8:(i*9)-1)=gradient_histogram(grad_x,grad_y);


end

% normalise vector to unit length
desc=normalize(histogram);

end