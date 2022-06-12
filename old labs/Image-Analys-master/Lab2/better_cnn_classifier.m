function layers = better_cnn_classifier()

layers = [
imageInputLayer([28 28 1]);
convolution2dLayer(5, 30,'padding', 2);%-->24x24x30
%Create a 
%convolutional layer with 10 filters that have a height and width of 28, 
%and use a stride of 2 in the horizontal and vertical directions.
reluLayer();
maxPooling2dLayer(2,'Stride', 2);%-->12x12x30
convolution2dLayer(3, 60, 'padding', 1);%--->22x22x
reluLayer
dropoutLayer();
fullyConnectedLayer(10);
softmaxLayer();
classificationLayer()];

% image is 28x28 --> conv 30 5x5-filters + relu --> 30x28x28 --> max pooling 
% --> 30x14x14 --> conv 20 3x3-filters + relu --> 20x14x14 ---> max pooling
% ---> 20x7x7 ---> 