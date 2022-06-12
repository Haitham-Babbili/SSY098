function layers = better_cnn_classifier()

layers = [
imageInputLayer([28 28 1]);
convolution2dLayer(5, 30,'padding', 2);% introduce padding
reluLayer(); %act as activation function or sigmod function
maxPooling2dLayer(2,'Stride', 2);
convolution2dLayer(3, 60, 'padding', 1);
reluLayer
maxPooling2dLayer(1,'Stride', 1);
convolution2dLayer(2, 120, 'padding', 1);
reluLayer
dropoutLayer(); % random set input element to zero with a given probability
fullyConnectedLayer(10);
softmaxLayer();
classificationLayer()];
end

