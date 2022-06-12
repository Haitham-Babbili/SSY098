addpath('datasets');

[XTrain, YTrain, XTest, YTest] = load_dataset('mnist');
%%

% path of our mnist data files 
train_img_filename = 'digits/train-images-idx3-ubyte';
train_lbl_filename = 'digits/train-labels-idx1-ubyte';
test_img_filename = 'digits/test-images-idx3-ubyte';
test_lbl_filename = 'digits/test-labels-idx1-ubyte';
%%
%loading the training data.
[train_image, train_label] = nread_data(train_img_filename, train_lbl_filename, 60000, 0);
%loading the testing data
[test_image,  test_label] =  nread_data(test_img_filename , test_lbl_filename, 10000, 0);
figure                                          % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(train_image(:,i), [28,28])';    % row = 28 x 28 image
    imagesc(digit)                              % show the image
    title(num2str(train_label(i)))                    % show the label
end

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
    'MaxEpochs', 5, ...
    'MiniBatchSize', 128, ...
    'VerboseFrequency',30, ...
    'ValidationData',{XTest, YTest}, ...
    'ValidationFrequency', 30, ...
    'Plots','training-progress','OutputFcn',@(info)stopIfAccuracyNotImproving(info,3));


%%
%load net_mnist.mat
net = trainNetwork(XTrain, YTrain,layers,options);%to train

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
[bboxes,score,label] = detect(rcnn,testImage,'MiniBatchSize',128);
%%
% Display the detection results
%  [score, idx] =score;
% 
%  bbox = bboxes(idx, :);
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
load dataa.mat
[C,scores] =semanticseg(testImage,data.net,'MiniBatchSize',32);

B = labeloverlay(testImage,C);
montage({testImage,B})
figure
imagesc(scores)
axis square
colorbar
BW = C == 'triangle';
figure
imshow(BW)

