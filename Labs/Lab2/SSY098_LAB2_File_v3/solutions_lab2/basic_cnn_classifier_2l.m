function layers = basic_cnn_classifier_2l()

layers = [
imageInputLayer([28 28 1]);
convolution2dLayer(5, 10);%This is to create a convolutional layer with
%20 filters that have a height and width of 5
reluLayer();
% convolution2dLayer(5, 10);% 
convolution2dLayer(3, 10);
reluLayer();
convolution2dLayer(3, 10); 
reluLayer();
maxPooling2dLayer(2,'Stride', 2);
convolution2dLayer(5, 10);
reluLayer();
maxPooling2dLayer(1,'Stride', 1);
convolution2dLayer(5, 20); 
reluLayer();
maxPooling2dLayer(1,'Stride', 1);
fullyConnectedLayer(10);
softmaxLayer();
classificationLayer()];
end

