function digits_training = prepare_digits(digits_training)
% - INPUT
% A struct with array fields: 
%   matrix containing a image
%   a label describing the image content
% 
% - OUTPUT
% A struct with array fields: 
%   matrix containing a image
%   a label describing the image content
%   a descriptor 

% Centre of image
centre = [floor(size(digits_training(1).image,1)/2) floor(size(digits_training(1).image,2)/2)];

% Radius from the distance from the pic. centrum to pic. edge, divide by 3 due to having 3 radiuses to the edge 
radius = floor((size(digits_training(1).image,1)-centre(1,1)) / 3) ; 

    for k= 1:numel(digits_training) 
%       Use gradient_descriptor function on the training images
        digits_training(k).descriptor=gradient_descriptor(digits_training(k).image, centre, radius );
    end

end 