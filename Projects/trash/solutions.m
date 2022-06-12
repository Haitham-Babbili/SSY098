clc;
clear all;
close all;

%%

load ('mnist.mat')

% d = load('mnist.mat');

% d.trainX is a (60000,784) matrix which contains the pixel data for training
% d.trainY is a (1,60000) matrix which contains the labels for the training data
% d.testX is a (10000,784) matrix which contains the pixel data for testing
% d.testY is a (1,10000) matrix which contains the labels for the test set

% X = d.trainX;
% i = reshape(X(3,:), 28, 28)';
% image(i);
%%
img_train = MNIST_image_file('train-images.idx3-ubyte'); % train images
label_train = MNIST_labels_file('train-labels.idx1-ubyte'); % train labels

% Split training set into training and validation set with ratio 90/10 %
% 75-25
images_train = img_train(:,1:0.75*size(img_train,2));               % Training images              
labels_train = label_train(1:0.75*size(label_train,1),1);               % Training labels

images_valid = img_train(:,1:0.25*size(img_train,2));              % Validation images
labels_valid = label_train(1:0.25*size(label_train,1),1);              % Validation labels

% Load the test dataset. This dataset is untouched during the training
% process
images_test = MNIST_image_file('t10k-images.idx3-ubyte');   % Testing images
labels_test = MNIST_labels_file('t10k-labels.idx1-ubyte');   % Testing labels





%%
% % Preview the first 36 samples from MNIST dataset (optional)
figure ()
colormap(gray)                  % set to grayscale

for i = 1:36                               % preview the first 36 samples
    subplot(6,6,i)                          % plot them in 5x5, 6x6 grid or 8x8 grid
    digit = reshape(images_train(:,i), [28,28]);    % row = 28x28 image
    imagesc(digit)                          % show the image
    title(num2str(labels_train(i)))                 % show the label    
end

%%
% Reshape the images data into 4D matrix 28x28x1x60000 (1 is because of
% gray scale), and convert labels data into categorical in order to be used
% in Convolutional Neural Network
cnn_images = reshape(images_train,28,28,1,size(images_train,2));
cnn_labels = categorical(labels_train);

% A categorical array provides efficient storage and convenient manipulation 
% of nonnumeric data, while also maintaining meaningful names for the values. 
% A common use of categorical arrays is to specify groups of rows in a table.
cnn_images_valid = reshape(images_valid,28,28,1,size(images_valid,2));
cnn_labels_valid = categorical(labels_valid);

images_test = reshape(images_test,28,28,1,size(images_test,2));
labels_test = categorical(labels_test);

%% 
% Designed  CNN Solution
layers = [...
    imageInputLayer([28 28 1])
    
    convolution2dLayer(5,20)             % Filter 1: 20 filters size 5x5
    batchNormalizationLayer              % This normalizes each input channel across a mini-batch. It is used to speed up training of convolutional neural networks and reduce the sensitivity to network initialization,between convolutional layers and nonlinearities, such as ReLU layers.

    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)     % Pooling layer: 2x2 with Stride 2
    
    convolution2dLayer(3,10)            % Filter 2: 10 filters size 3x3
    batchNormalizationLayer
    reluLayer
    
    %maxPooling2dLayer(2,'Stride',2)     % Pooling layer: 2x2 with Stride 2
    
    fullyConnectedLayer(10)             % Fully connected network layer
    softmaxLayer
    pixelClassificationLayer];
    %classificationLayer];               % Softmax layer with 10 classes



%%
% Training options
options = trainingOptions('sgdm',...
    'ExecutionEnvironment','auto',...
    'InitialLearnRate', 0.09,...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.5,...
    'LearnRateDropPeriod',1,...
    'ValidationData',{cnn_images_valid,cnn_labels_valid},...
    'ValidationFrequency',50,...
    'ValidationPatience',6,...
    'MaxEpochs',5,...
    'MiniBatchSize',256,...
    'Plots','training-progress');

% This is to Train the network
% Use trainNetwork to train a convolutional neural network (ConvNet, CNN), 
% a long short-term memory (LSTM) network, or a bidirectional LSTM (BiLSTM)
% network for deep learning classification and regression problems. You can 
% train a network on either a CPU or a GPU
net = trainNetwork(cnn_images,cnn_labels,layers,options);

% Testing the trained network
prediction = classify(net,images_test);
test_Y = labels_test;

% Display the accuracy based on test set
test_accuracy = (sum(prediction == test_Y)/numel(test_Y))*100;


%%
 gtruth = load('gTruthfile.mat');

%%
% Apply on given images:
figure ()
classify(net,mnist_dataset('computer_generated.png'))
figure ()
classify(net,mnist_dataset('computer_generated_rotated.png'))
figure ()
classify(net,mnist_dataset('handwritten.png'))
figure ()
classify(net,mnist_dataset('handwritten_rotated.png'))



% classify(net,process('IMAGE_NAME.jpg'))

%%

I = imread('computer_generated.png');
figure ()
imshow(I)


[C,scores] = semanticseg(I,net,'MiniBatchSize',32);



B = labeloverlay(I, C);
figure ()
imshow(B)

figure ()
imagesc(scores)
axis square
colorbar


BW = C == 'square';
figure ()
imshow(BW)

%%

 I= imread('computer_generated.png');
[C,scores] = semanticseg(I,net);

B = labeloverlay(I,C);
montage({I,B})

%%

[imgs_test, labels_test] = digitTest4DArrayData;
pred = net.classify(imgs_test) == labels_test;
failure = find(pred == 0);

for i=1:5

mistaken_as = net.classify(imgs_test(:,:,:,failure(i)));

imwrite(imgs_test(:,:,:,failure(i)), (['mistaken_as_' char(mistaken_as) '.png']))

end

