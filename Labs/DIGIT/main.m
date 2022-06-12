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
load net_mnist.mat
%net = trainNetwork(XTrain, YTrain,layers,options);
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


 %%  
load network.mat      
% Extract the first convolutional layer weights
w = cifar10Net.Layers(2).Weights;

% rescale the weights to the range [0, 1] for better visualization
w = rescale(w);


%%
% Load the ground truth data
load maindata.mat

%%

T = T(:, {'imageFilename','six','one','zero','Two','Three','Seven','Eight','Four','Nine','Five'});
%%
% Display one training image and the ground truth bounding boxes
I = imread(T.imageFilename{3});
I = insertObjectAnnotation(I,'Rectangle',T.six{1},'six','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.one{1},'one','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.zero{1},'zero','LineWidth',8);


figure
imshow(I)
%%
load ntworkk.mat
 %%   
    % Train an R-CNN object detector. This will take several minutes.    
%     rcnn = trainRCNNObjectDetector(T, cifar10Net, options, ...
%     'NegativeOverlapRange', [0 0.3], 'PositiveOverlapRange',[0.5 1])

%%
% Read test image
testImage = imread('computer_generated.png');
imshow(testImage)
% Detect stop signs
[bboxes,score,label] = detect(rcnn,testImage,'MiniBatchSize',128)
%%
% Display the detection results
% [score, idx] =score

% bbox = bboxes(idx, :);
for idx=1:22
annotation = [sprintf('%s: (Confidence = %f)', label(idx), score(idx));];
le{idx}=annotation;
end
outputImage = insertObjectAnnotation(testImage, 'rectangle', bboxes, le);
imshow(outputImage)
pause(1)
for i=1:22
    w=label(i,:);
tts(char(w));
end
% hold on

%%
