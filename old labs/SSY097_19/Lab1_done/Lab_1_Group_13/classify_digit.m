function digit_classified = classify_digit(unknow_digit, digits_training);
% - INPUT
% A unknown digit (image), struct with known image and label
% 
% - OUTPUT
% Struct with a guess of what the unknown digit was

% Centre of image
centre= [floor(size(digits_training(1).image,1)/2) floor(size(digits_training(1).image,2)/2)  ];

% Radius from the distance from the pic. centrum to pic. edge, divide by 3 due to having 3 radiuses to the edge 
radius= floor((size(digits_training(1).image,1)-centre(1,1)) / 3) ; 

% Create descriptor of unknown number
prepared_unknown = gradient_descriptor(unknow_digit,centre,radius);
% Prepare known digits, create descriptor to compare with
digits_training = prepare_digits(digits_training);

min_diff= inf;

for k=1:length(digits_training)
    desc_diff= sum( abs(prepared_unknown - digits_training(k).descriptor));
    
%   If decriptor for k is less then previous, set it equal to that label
    if desc_diff < min_diff  
       min_diff= desc_diff; 
       label = digits_training(k).label; 
       training_index = k; 
    end
end
digit_classified.label=label; 
digit_classified.training_index = training_index;
end 
