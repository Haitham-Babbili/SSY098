function recall = compute_recall( predict, real )
%COMPUTE_RECALL Compute recall from predicted results and known data.
%   Input arguments :
%   - predict : a vector contains predicted labels
%   - real : a vector contains real labels
%   Output :
%   - recall : recall of predicted result
%             true positives in predicted labels
%   recall = ------------------------------------
%                all positives in real labels

% There are 26 characters, calculate recall for each one
iter = 26;

% Initialize a vector to store recall for each character
recall = zeros(iter, 1);

for i = 1 : iter
    
    % Find out the number of true positives in predicted labels
    true_positive = length(intersect(find(predict == i),find(real == i)));
    % Find out the number of all positives in real labels
    real_positive = length(find(real == i));
    % Calculate recall
    recall(i) = true_positive / real_positive;

end

end