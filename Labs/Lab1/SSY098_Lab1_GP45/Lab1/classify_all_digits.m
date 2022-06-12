function conceal = classify_all_digits(dig_authorized,digits_training)
%This function is to classify each validated image in validation set.
%  Input Information:
%  digits_validation : This an image set contains a set of test images
% digits_training is an image set contains 100 training images whose
% SIFT-like descriptors has been calculated via classify_digit function

 
conceal = [];
 
 digits_training=prepare_digits(digits_training); 
 
for j =1:numel(dig_authorized)

  % output recieves the info of what the inputimage is classified as 
  % and which training image it was matched against [label, training_index] 
    kk  =classify_digit(dig_authorized(j).image,digits_training); 
    conceal (j).address=kk;
%     conceal (j).training_index=kk.training_index;
%     kk.address
    % checks the true label of the input image 
    evaluation=dig_authorized(j).label;
    
    % if the label of the conceal  image == label of input image sets a
    % flag for correctly conceal . if not sets flag to zero
%     kk.label
    if isequal(kk.address,evaluation)==1
        conceal (j).correctly_classified=1;
        
    else
        conceal (j).correctly_classified=0;
        
    end
    
end 
    
end

