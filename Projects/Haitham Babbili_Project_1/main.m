close all;
clear;
clc;

d = load('mnist.mat');


% d.trainX is a (60000x784) matrix which contains the pixel data for training
% d.trainY is a (1x60000) matrix which contains the labels for the training data
% d.testX is a (10000x784) matrix which contains the pixel data for testing
% d.testY is a (1x10000) matrix which contains the labels for the test set


x = double (d.trainX')/ 255.0;                            % double training data
y = double (d.trainY')/ 255.0;                             % double training labels

x_t = double (d.testX')/ 255.0;                            % double testing data
y_t = double (d.testY')/ 255.0;

train_images = x(:,1:0.75*length(x));               % Training images              
train_lable = y(1:0.75*length(y),1);               % Training labels

valid_images = x(:,1:0.25*length(x));              % Validation images
valid_labels = y(1:0.25*length(y),1);              % Validation labels

%%
figure(1)
 colormap(gray)                                      % set to grayscale

for i = 1:49                                        % preview the first 49 samples
    subplot(7,7,i)                                  % plot them in 7x7 grid
    data = reshape(train_images(:,i), [28,28]);    % row = 28x28 image
    imagesc(data')                                 % show the image
    title(num2str(train_lable(i)))                  % show the label    
end

% Reshape the images data into 4D matrix 28x28x1x60000 (1 is because of
% gray scale), and convert labels data into categorical in order to be used
% in Convolutional Neural Network
cnn_images = reshape(train_images,28,28,1,length(train_images));
cnn_labels = categorical(train_lable);

cnn_valid_images = reshape(valid_images,28,28,1,length(valid_images));
cnn_valid_labels = categorical(valid_labels);

test_images = reshape(x_t,28,28,1,length(x_t));
test_labels = categorical(y_t);


%% Define CNN architecture
[imgs, labels] = digitTrain4DArrayData;

% Set-up of a better CNN classifier
layers = [
imageInputLayer([28 28 1]);
convolution2dLayer(5, 20,'Padding','same');
batchNormalizationLayer   
reluLayer(); %act as an activation function or sigmod function
maxPooling2dLayer(2,'Stride', 2);

convolution2dLayer(3, 16, 'Padding',1); %Introduce more layers
batchNormalizationLayer;   
reluLayer();
maxPooling2dLayer(2,'Stride', 2);

convolution2dLayer(3, 32, 'Padding',1); %Introduce more layers
batchNormalizationLayer;   
reluLayer();
maxPooling2dLayer(2,'Stride', 2);
% fullyConnectedLayer(10);
% pixelClassificationLayer
softmaxLayer();
% classificationLayer()
pixelClassificationLayer();

];

% Training options
options = trainingOptions('sgdm',...
    'ExecutionEnvironment','auto',...
    'InitialLearnRate', 0.1,...
    'MaxEpochs',7,...
    'LearnRateDropFactor',0.5,...
    'LearnRateDropPeriod',50,...
    'LearnRateSchedule','piecewise',...
    'ValidationData',{cnn_valid_images,cnn_valid_labels},...
    'ValidationFrequency',50,...
    'ValidationPatience',6,...
    'MiniBatchSize',256,...
    'Plots','training-progress');

% Train the network
net = trainNetwork(cnn_images,cnn_labels,layers,options);

save('net.mat', 'net');

% Test trained network
pred = net.classify(test_images);

% Display the accuracy based on test set
accuracy_mesurment = (sum(pred == test_labels)/numel(test_labels))*100;
accuracy_mesurment

%%
I = imread('triangleTest.jpg');
[C,scores] = semanticseg(I,net);
pxdsPred = semanticseg(test,net,'MiniBatchSize', 64, 'WriteLocation','preds');

B = labeloverlay(I,C);
montage({I,B})
%% Test an image

figure ()
% classify(net,test_dataset('digit_classification/computer_generated.png'))
% figure ()
% classify(net,test_dataset('digit_classification/computer_generated_rotated.png'))
% figure ()
% classify(net,test_dataset('digit_classification/handwritten.png'))
% figure ()
% classify(net,test_dataset('digit_classification/handwritten_rotated.png'))

%% Failer image
[imgs_test, labels_test] = digitTest4DArrayData;
pred = net.classify(imgs_test) == labels_test;
failure = find(pred == 0);

failer = net.classify(imgs_test(:,:,:,failure(i)));
imwrite(imgs_test(:,:,:,failure(i)), (['failure_' char(failer) '.png']));

