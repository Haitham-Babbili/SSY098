function digits_training = prepare_digits(digits_training)


position = [floor(size(digits_training(1).image,1)/2) floor(size(digits_training(1).image,2)/2)];

radius= floor((size(digits_training(1).image,1)-position(1,1)) / 3) ;

    for i= 1:numel(digits_training) 

        digits_training(i).descriptor=gradient_descriptor(digits_training(i).image, position, radius );
    end
    

end

