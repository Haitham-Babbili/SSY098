function [examples_train_aug,labels_train_aug] = augment_data(examples_train,labels_train,M)
examples_train_aug = cell(1,length(examples_train)*M);
labels_train_aug = nan(1,length(examples_train)*M);
for i=1:length(examples_train)
    for j=1:M
        r_angle = 90*(-2*rand+1); % random angle between -90 and 90;
        temp = imrotate(padarray(examples_train{i},[10 10],'symmetric'),r_angle,'bilinear','crop');
        examples_train_aug{i*M+j-M} = temp(11:45,11:45);
        labels_train_aug(i*M+j-M) = labels_train(i);
    end
end