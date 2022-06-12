function label=classify_digit(digit_image,digits_training)
% go through saved descriptors and take norm difference
S=size(digits_training,2);
diff=zeros(S,1);
descriptor=gradient_descriptor(digit_image,[20;20],6);
prepare_digits;
for i=1:S
    % if you cannot be assumed to have used prepare_digits
    % then exchange gradient_descriptor with 
    % desc2=gradient_descriptor(digits_training(i).image,[20;20],6);
   desc2=digits_training(i).desc;
   diff(i)=norm(desc2-descriptor);
end
[M,I]=min(diff);
label=digits_training(I).label;
end