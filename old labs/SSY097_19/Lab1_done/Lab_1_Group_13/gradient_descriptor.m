function desc = gradient_descriptor(image, position, radius)
% - INPUT
% Image (greyscale), position, radius
% 
% - OUTPUT
% Vector of length 72 containing 9 historgams stacked on each other 

histogram_tot=zeros(8,9); 
dev=radius/10; 

% retreive the region centers
region_centres=place_regions(position,radius);

for ii=1:9 
%   Retrieve patch at region center for region "ii"
    patch = get_patch(image, region_centres(1,ii), region_centres(2,ii), radius);
%   Calculate gradients on patch "ii"
    [x_grad, y_grad]=gaussian_gradients(patch,dev); 
%   Creata histogram for patch "ii"
    histogram = gradient_histogram(x_grad, y_grad);
%   Add histogram "ii" to histogram matrix
    histogram_tot(:,ii)=histogram; 
end 

% Reshape matrix into vector
histogram_long= reshape(histogram_tot,1,72); 
% Normalize histogram vector
desc= histogram_long/norm(histogram_long);

end 