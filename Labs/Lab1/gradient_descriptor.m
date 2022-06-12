function desc = gradient_descriptor(image, position, radius)


hist=zeros(8,9); 
sigma=radius/4; 
% length(hist(1,:)) 
local_centres=place_regions(position,radius);

for kk=1:length(hist(1,:)) 

    patch = get_patch(image, local_centres(1,kk), local_centres(2,kk), radius);

    [x_grad, y_grad]=gaussian_gradients(patch,sigma); 

    histogram = gradient_histogram(x_grad, y_grad);

    hist(:,kk)=histogram; 
end 


extanded_hist= reshape(hist,1,72); 

desc= extanded_hist/norm(extanded_hist);

end 



