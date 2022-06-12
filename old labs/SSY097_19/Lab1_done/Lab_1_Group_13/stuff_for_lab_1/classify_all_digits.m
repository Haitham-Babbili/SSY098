function classified = classify_all_digits(digits_validation,digits_training)
% - INPUT
% struct with numbers to validate, struct with known image and label
% 
% - OUTPUT
% Struct with a guess of what the unknown digit was
 
classified= struct;
 
 digits_training=prepare_digits(digits_training); 
 
for ii =1:numel(digits_validation)
    ii
    % output recieves the info of what the inputimage is classed as & which
    % training img it was match against [label, training_index] 
    tmp  =classify_digit(digits_validation(ii).image,digits_training); 
    classified(ii).label=tmp;
%     classified(ii).training_index=tmp.training_index;
    
    % checks the true label of the input image 
    validation=digits_validation(ii).label;
    
    % if the label of the classified image == label of input image sets a
    % flag for correctly classified. if not sets flag to zero
    
    if isequal(tmp.label,validation)==1
        classified(ii).correctly_classified=1;
        
    else
        classified(ii).correctly_classified=0;
        
    end
    
end 
    
end

