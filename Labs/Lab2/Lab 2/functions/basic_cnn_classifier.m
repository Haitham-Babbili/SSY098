function layers = basic_cnn_classifier()
% create the layers according to PM for Ex 2.11
layers = [
imageInputLayer([28 28 1]); % The image size
convolution2dLayer(5,20); % 20 5x5 convolutional filters
reluLayer();
maxPooling2dLayer(2,'stride',2);
fullyConnectedLayer(10);
softmaxLayer();
classificationLayer()];
end

