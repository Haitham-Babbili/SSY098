function layers = basic_cnn_classifier_2l()

layers = [
imageInputLayer([28 28 1]);
convolution2dLayer(5, 10);%Create a 
%convolutional layer with 20 filters that have a height and width of 5
reluLayer();
% convolution2dLayer(5, 10);%Create a 
convolution2dLayer(3, 10);%Create a 
reluLayer();
convolution2dLayer(3, 10);%Create a 
reluLayer();
maxPooling2dLayer(2,'Stride', 2);
convolution2dLayer(5, 10);%Create a 
reluLayer();
maxPooling2dLayer(1,'Stride', 1);
convolution2dLayer(5, 20);%Create a 
reluLayer();
maxPooling2dLayer(1,'Stride', 1);
fullyConnectedLayer(10);
softmaxLayer();
classificationLayer()];
end

