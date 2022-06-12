function [net, net_accuracy]= train_classifier(layers, imgs_train, labels_train, imgs_val, labels_val)
options = trainingOptions('sgdm','MaxEpochs',15);
net = trainNetwork(imgs_train, labels_train,layers, options);
guesses = net.classify(imgs_val);
net_accuracy = sum(guesses == labels_val)/length(labels_val)*100;
end

