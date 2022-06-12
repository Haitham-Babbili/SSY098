function conceal = classify_all_digits(dig_authoriz,digits_training)
% - INPUT
% struct with numbers to validate, struct with known image and label
% 
% - OUTPUT
% Struct with a guess of what the unknown digit was
 
conceal = [];
 
 digits_training=prepare_digits(digits_training); 
 
for j =1:numel(dig_authoriz)

    % output recieves the info of what the inputimage is classed as & which
    % training img it was match against [label, training_index] 
    kk  =classify_digit(dig_authoriz(j).image,digits_training); 
    conceal (j).address=kk;
%     conceal (j).training_index=kk.training_index;
%     kk.address
    % checks the true label of the input image 
    evaluation=dig_authoriz(j).label;
    
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

