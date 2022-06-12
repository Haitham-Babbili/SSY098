function desc = gradient_descriptor(image, position, radius)
%Ths function is to generate the SIFT_like descriptor of a patch in image.
%   Input Inforamtion:
%   - image : a full scale image that contains the patch
%   - position : the position of the patch's centre in given image
%   -radius

%   Output:
%   - Stacked histograms into a 72-vector
%   - 72 x 1 vector indicates the SIFT-like descriptor of the patch

hist=zeros(8,9); 
sigma=radius/4; 
% length(hist(1,:)) 
local_centres=place_regions(position,radius);

    for kk=1:length(hist(1,:)) 
    % Call for the patch at the region center for region "kk"
        patch = get_patch(image, local_centres(1,kk), local_centres(2,kk), radius);
    %   Calculatation of the gradients on patch "kk"
        [x_grad, y_grad]=gaussian_gradients(patch,sigma); 
    % Then, create a histogram for patch "kk"
        histogram = gradient_histogram(x_grad, y_grad);
    % This is for the addition of histogram "kk" to histogram matrix
        hist(:,kk)=histogram; 
    end 

%This is to reshape the matrix into vector
extended_hist= reshape(hist,1,72); 
% This to normalize the histogram vector
desc= extended_hist/norm(extended_hist);

end 



