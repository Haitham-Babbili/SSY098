function net = train_classifier(layers, imgs_train, labels_train) %, imgs_val, labels_val)

    % Train for 1 epochs
    options = trainingOptions('sgdm','MaxEpochs',2,'InitialLearnRate',0.1);
    net = trainNetwork(imgs_train,labels_train,layers,options);
     
end





