function [examples_train_aug,labels_train_aug]= augment_data(examples_train,labels_train,M)
N=size(labels_train,1);
examples_train_aug=cell(M*N,1);
labels_train_aug=zeros(M*N,1);

for i=1:N
    % for each example apply M rotations
    for j=1:M
        % apply rotation
        angle=randi(360);
        Img=imrotate(examples_train{i},angle,'crop'); % crop to get same size as input
        % save image and label
        examples_train_aug{i*M+j-M}=Img;
        labels_train_aug(i*M+j-M)=labels_train(i);
    end
end
