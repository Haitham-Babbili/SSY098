load digits.mat
nrofimg = length(digits_validation);
sum = 0;
for i=1:nrofimg
    label = classify_digit(digits_validation(i).image, digits_training);
    if digits_validation(i).label == label
        sum= sum+1;
    end
end

disp([num2str((sum/nrofimg)*100) '% of the digits were matched correctly'])