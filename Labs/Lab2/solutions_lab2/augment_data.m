function [examples_train_aug,labels_train_aug] = augment_data(examples_train,labels_train,M)

exa_tr=str2double(examples_train); % chang from cell to duble
% leb_tr=str2double(labels_train);


exa_tr_aug=imrotate(exa_tr,M);         % rotate it and augmante it
leb_tr_aug=imrotate(labels_train,M);  % rotate it and augmante it

examples_train_aug= num2cell(exa_tr_aug); % chang back to cell
labels_train_aug= num2cell(leb_tr_aug);   % chang back to cell
end

