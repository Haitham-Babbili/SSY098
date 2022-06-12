function classify_all_digits( digits_validation, digits_training )
%CLASSIFY_ALL_DIGITS Classify each validation image in validation set.
%   Input arguments:
%   - digits_validation : an image set contains 50 test images
%   - digits_training : an image set contains 100 training images whose
%   SIFT-like descriptors has been calculated in last step

% Obtain the number of validation number
num_valid = length(digits_validation);

% Initialize the number of digits that can be classified correctly
right_pred = 0;

for i = 1 : num_valid
    
    % Get the label of ith validation image
    label = classify_digit( digits_validation(i).image, digits_training);
    
    % Accumulate the number of digits that can be classified correctly
    if label == digits_validation(i).label
        right_pred = right_pred + 1;
    end
    
end

% Compute the classify accuracy and print the result
accuracy = right_pred / num_valid;

fprintf('Validate all %d validation images\n', num_valid)
fprintf('%.2f%% validation images can be recognized.\n\n', accuracy * 100)

end

