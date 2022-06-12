%% classify_all_digits
sum=0;
% take each image in validation and classify it
S=size(digits_validation,2);
for i=1:S
    label=classify_digit(digits_validation(i).image,digits_training);
   
    if(strcmp(num2str(label),num2str(digits_validation(i).label)))
        sum=sum+1;
    end
end
disp(['Amount correct: ' num2str(sum) ' out of ' num2str(S)])
percent=sum/S;
disp(['Percent correct:' num2str(100*percent) '%'])