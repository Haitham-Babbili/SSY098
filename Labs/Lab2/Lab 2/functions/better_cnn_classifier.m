function layers = better_cnn_classifier()
% create the layers according to PM for Ex 2.11
layers = [
imageInputLayer([28 28 1]); % The image size
convolution2dLayer(5,20); % 20 5x5 convolutional filters
reluLayer(); %ReLU layer
maxPooling2dLayer(2,'stride',2);
% add more layers, just copied the same layers as before
convolution2dLayer(3,10);
reluLayer();
fullyConnectedLayer(10); % connect all points
softmaxLayer();
classificationLayer()];
end

