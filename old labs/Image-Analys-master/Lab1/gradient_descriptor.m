function desc = gradient_descriptor(image, position, radius)

all_histogram = zeros(8,9); %creates 8x9 matrix for saving histogram results
std = radius/10; %sets gaussian blur standard deviation with respect to radius
region_centres = place_regions(position, radius);

for i=1:9
patch = get_patch(image, region_centres(2,i), region_centres(1,i), radius);

[grad_x, grad_y] = gaussian_gradients(patch, std);

histogram = gradient_histogram(grad_x, grad_y);

all_histogram(:,i) = histogram;

end

histogram72 = reshape(all_histogram, 1, 72);

desc = histogram72/norm(histogram72);