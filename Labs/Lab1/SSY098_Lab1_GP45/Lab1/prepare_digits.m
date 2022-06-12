function digits_training = prepare_digits(digits_training)
% This function is for digits training, in order to calculate SIFT-like 
%descriptor for each image in training set.
%   Input Arguments:
%   - digits_training : a training set with 100 images
%   Output Information
%   -A structure of arrays (desc), matrix containing a image and descriptor
%This is a new training set with SIFT-like descriptors
 

position = [floor(size(digits_training(1).image,1)/2) floor(size(digits_training(1).image,2)/2)];

radius= floor((size(digits_training(1).image,1)-position(1,1)) / 3) ;

    for i= 1:numel(digits_training) 

        digits_training(i).descriptor=gradient_descriptor(digits_training(i).image, position, radius );
    end
    

end

