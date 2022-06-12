function label = classify_digit(digit_image, digits_training)
    
    whatdigit = gradient_descriptor(digit_image, [20, 20], 6);
    digits_training = prepared_digits(digits_training);
    
    pyt = 100;
    age = 11;
    
    for i=1:length(digits_training)
       pyt1 = sum(abs((whatdigit)-(digits_training(i).descriptor)));
       if pyt1 < pyt
           pyt = pyt1;
           age = digits_training(i).label;
       end
    end
    
    label = age;
    
    %disp(['I am ' num2str(age) ' years old']);