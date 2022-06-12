function label = classify_digit(digit_image, digits_training)

% - INPUT
% A unknown digit image, correlated with known image and label
% 
% - OUTPUT
% Correlation to determine what the unknown digit was

% The centre of image can be estimated......
position = [floor(size(digits_training(1).image,1)/2) floor(size(digits_training(1).image,2)/2)];

% Radius from the distance from the centre to edge of the given image 
% The division by 3 is due to having 3 radii to the edge
radius= floor((size(digits_training(1).image,1)-position(1,1)) / 3) ;


% Create descriptor of X, which for now, is unknown
X_decriptor = gradient_descriptor(digit_image,position,radius);

% Scenario to prepare known digits, and compare with created descriptor
digits_training = prepare_digits(digits_training);

variance= inf;
for i=1:numel(digits_training)
    error_desc= sum( abs(X_decriptor - digits_training(i).descriptor));
    
%  If decriptor for 'i' is less than the previous, 
%  then, set it equal to that label
    if error_desc < variance  
       variance= error_desc; 
       address = digits_training(i).label; 
       index_train = i; 
    end
end
label.address = address; 
label.index = index_train;
end

