function label = classify_digit(digit_image, digits_training)

position = [floor(size(digits_training(1).image,1)/2) floor(size(digits_training(1).image,2)/2)];

radius= floor((size(digits_training(1).image,1)-position(1,1)) / 3) ;



X_decriptor = gradient_descriptor(digit_image,position,radius);

digits_training = prepare_digits(digits_training);

variance= inf;
for i=1:numel(digits_training)
    error_desc= sum( abs(X_decriptor - digits_training(i).descriptor));
    

    if error_desc < variance  
       variance= error_desc; 
       address = digits_training(i).label; 
       index_train = i; 
    end
end
label.address = address; 
label.index = index_train;
end

