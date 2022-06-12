function net=train_classifier(layers, imgs_train, labels_train, imgs_val, labels_val)

options = trainingOptions('sgdm',...
            'MaxEpochs', 5, ...
            'InitialLearnRate', 0.1);

net = trainNetwork(imgs_train, labels_train, layers, options);


     truelabel = net.classify(imgs_val) == labels_val;

nbrcorrect = (sum(truelabel)/length(imgs_val))*100;
disp([num2str(nbrcorrect) '% correct classifications!'])
end