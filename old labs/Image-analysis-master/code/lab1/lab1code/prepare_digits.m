%% prepare digits
load('digits.mat');

% 39*39 images -> radius 6 & position (20,20)
desc_train=zeros(72,100);

% compute descriptors
for i=1:100
    desc_train(:,i)=gradient_descriptor(digits_training(i).image,[20;20],6);
end

% save into struct
N=mat2cell(desc_train,72,ones(1,100));
[digits_training(:).desc]=N{:};