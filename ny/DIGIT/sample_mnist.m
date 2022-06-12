addpath('datasets');

[XTrain, YTrain, XTest, YTest] = load_dataset('mnist');

%%
% nb_features = 256;
% nb_classes = 10;
layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs', 100, ...
    'MiniBatchSize', 128, ...
    'VerboseFrequency',30, ...
    'ValidationData',{XTest, YTest}, ...
    'ValidationFrequency', 30, ...
    'Plots','training-progress','OutputFcn',@(info)stopIfAccuracyNotImproving(info,3))
%%
net = trainNetwork(XTrain, YTrain,layers,options);
%%
YPred = predict(net,XTrain);
acc = mean_accuracy( YTrain, YPred );
ce = mean_cross_entropy( YTrain, YPred );
fprintf( 'Train mean accuracy: %g\n', acc );
fprintf( 'Train mean cross entropy: %g\n\n', ce );

YPred = predict(net,XTest);
acc = mean_accuracy( YTest, YPred );
ce = mean_cross_entropy( YTest, YPred );
fprintf( 'Test mean accuracy: %g\n', acc );
fprintf( 'Test mean cross entropy: %g\n\n', ce );
save( 'net_mnist.mat', 'net' );

