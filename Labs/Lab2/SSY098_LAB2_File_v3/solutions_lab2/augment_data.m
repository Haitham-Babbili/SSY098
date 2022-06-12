function [examples_train_aug,labels_train_aug] = augment_data(examples_train,labels_train,M)
% Function file that takes each sample of the original training data and 
% applies M random rotations, and considered 90degrees maximum
examples_train_aug = cell(1,length(examples_train)*M); %cell array
labels_train_aug = nan(1,length(examples_train)*M);% Create array of all NaN value
for i=1:length(examples_train)
    for k=1:M
        angle_rotation =(-2*rand+1)*90; 
        trial_data = imrotate(padarray(examples_train{i},[10 10],'symmetric'),angle_rotation,'bilinear','crop');
        examples_train_aug{(i*M)+(k-M)} = trial_data(11:45,11:45);
        labels_train_aug((i*M)+(k-M)) = labels_train(i);
    end
end