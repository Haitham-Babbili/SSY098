function precision = compute_precision( predict, real )
%COMPUTE_PRECISION Compute precision from predicted results and known data.
%   Input arguments :
%   - predict : a vector contains predicted labels
%   - real : a vector contains real labels
%   Output :
%   - precision : precision of predicted result
%                 true positives in predicted labels
%   precision = --------------------------------------
%                 all positives in predicted labels

% There are 26 characters, calculate precision for each one
iter = 26;

% Initialize a vector to store precision for each character
precision = zeros(iter, 1);

for i = 1 : iter

    % Find out the number of true positives in predicted labels
    true_positive = length(intersect(find(predict == i), find(real == i)));
    % Find out the number of all positives in predicted labels
    prdt_positive = length(find(predict == i));
    % Calculate precision
    precision(i) = true_positive / prdt_positive;

end

end