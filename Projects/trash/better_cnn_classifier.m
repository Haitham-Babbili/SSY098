function layers = better_cnn_classifier()
% Set-up of a better CNN classifier
layers = [
imageInputLayer([28 28 1]);
convolution2dLayer(5, 20);
batchNormalizationLayer   
reluLayer(); %act as an activation function or sigmod function
maxPooling2dLayer(2,'Stride', 2);
convolution2dLayer(3, 10); %Introduce more layers
batchNormalizationLayer   
reluLayer
fullyConnectedLayer(10);
softmaxLayer();
classificationLayer()];
end

