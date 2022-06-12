function classify_img_digits( image, test_set, obj_num, real_labels )
%CLASSIFY_IMG_DIFITS Classify all digits in test image.
%   Input arguments:
%   - image : a test image that has been removed background, which has
%   13 digits in this case
%   - test_set : a struct consists of position and scale of each digit
%   - obj_num : the number of digits in test image
%   - real_labels : the true label for each digit

% Load training image set, each training image's SIFT-like dexcriptors are
% computed fitst
load digits.mat
digits_training = prepare_digits( digits_training );

% Initialize a vector to record predictions
predict = zeros(1, obj_num);

for i = 1 : obj_num

    % Get prediction label for each digit in test image
    predict(i) = classify_digit(image, digits_training,...
                                test_set(i).position, test_set(i).scale);
    
end

% Display all true labels and prediction labels
disp('Labels    Predictions')
disp([real_labels(:) predict(:)])

% Show all digits that is classified uncorrectly
error_pos = find(predict - real_labels ~= 0);
fprintf('No.%d is wrong,\nthe prediction is %d,but it should be %d.\n',...
        error_pos, predict(error_pos), real_labels(error_pos))

% Compute and display the classification accuracy
accuracy = 1- length(error_pos) / obj_num;
fprintf('Accuracy is %.2f%%.\n', accuracy * 100)

end

