close all;
clear;
clc;

d = load('mnist.mat');


% d.trainX is a (60000x784) matrix which contains the pixel data for training
% d.trainY is a (1x60000) matrix which contains the labels for the training data
% d.testX is a (10000x784) matrix which contains the pixel data for testing
% d.testY is a (1x10000) matrix which contains the labels for the test set


x = double (d.trainX');                            % double training data
y = double (d.trainY');                            % double training labels

x_t = double (d.testX');                            % double testing data
y_t = double (d.testY');

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
cnn_images=cnn_images/255;
cnn_labels = categorical(train_lable);

cnn_valid_images = reshape(valid_images,28,28,1,length(valid_images));
cnn_valid_images=cnn_valid_images/255;
cnn_valid_labels = categorical(valid_labels);

test_images = reshape(x_t,28,28,1,length(x_t));
test_images=test_images/255;
test_labels = categorical(y_t);


%% Define CNN architecture
[imgs, labels] = digitTrain4DArrayData;

% Set-up of a better FCN classifier
layers = [...
    imageInputLayer([28 28 1], 'Normalization', 'none'); % image input 28x28, no normalization of the input data 
    convolution2dLayer(5,10); 
    batchNormalizationLayer();    
    reluLayer();
    
    maxPooling2dLayer(2,'Stride',2);  
    
    convolution2dLayer(3,10);  
    batchNormalizationLayer();
    reluLayer();
    
    maxPooling2dLayer(2,'Stride',2);
    
    convolution2dLayer(3,10);  
    batchNormalizationLayer();
    reluLayer();
    
    
    convolution2dLayer(3,10);  
    batchNormalizationLayer();
    reluLayer();

    averagePooling2dLayer(1);
    softmaxLayer();
    pixelClassificationLayer()];  

% Training options
options = trainingOptions('sgdm',...
    'ExecutionEnvironment','auto',...
    'InitialLearnRate', 0.1,...
    'MaxEpochs',4,...
    'LearnRateDropFactor',0.5,...
    'LearnRateDropPeriod',50,...
    'LearnRateSchedule','piecewise',...
    'ValidationData',{cnn_valid_images,cnn_valid_labels},...
    'ValidationFrequency',50,...
    'ValidationPatience',6,...
    'MiniBatchSize',256,...
    'Plots','training-progress');

%% Train the network
net = trainNetwork(cnn_images,cnn_labels,layers,options);
%%
save('net.mat', 'net');
%%
% Test trained network Accuracy
pred = net.classify(test_images);

% Display the accuracy based on test set
accuracy_mesurment = (sum(pred == test_labels)/numel(test_labels))*100;
accuracy_mesurment


%% Failer image
[imgs_test, labels_test] = digitTest4DArrayData;
pred = net.classify(imgs_test) == labels_test;
failure = find(pred == 0);

failer = net.classify(imgs_test(:,:,:,failure(i)));
imwrite(imgs_test(:,:,:,failure(i)), (['failure_' char(failer) '.png']));

%%



imag = read_as_grayscale('computer_generated.png');

imag_rev = 1 - imag; 

%imshow(imag_rev)

% resize image - do upsampling 
img_scaled = imresize(imag_rev, 1.2);
% img_scaled = imresize(imag_rev, 8);
% img_scaled = imresize(imag_rev, 4);


[c, score] = semanticseg(img_scaled, net);

C = imresize(c, [768 1024],'nearest');
Score = imresize(score, [768 1024], 'nearest'); 

threshold = Score(1,1);

 
% if the image size increas, the result will became better
figure()
imagesc(Score)
title('Semantic image')
axis square
colorbar

%%

sigma = 1.05;
space_size = 3;

[h, w] = size(Score);     


scale_space = zeros(h,w,space_size);    
suppressed_img = zeros(h,w,space_size);
threshold_img = zeros(h,w,space_size);

%creating scale space
for i = 1:space_size    
    filtered_img = imfilter(Score, [28 28], 'replicate');
    filtered_img = filtered_img  * sigma * sigma;
    scale_space(:,:,i) = filtered_img;
%     sigma = sigma * 2;
%     k = ceil(2*(3*sigma + 1));
end



%performing non-maxima suppression and applying threshold)
for i = 1:space_size
    
    threshold_img(:,:,i) = scale_space(:,:,i).*(scale_space(:,:,i) > threshold);
    suppressed_img(:,:,i) = ordfilt2(threshold_img(:,:,i),9, ones(3,3)); 
    suppressed_img(:,:,i) = suppressed_img(:,:,i).*(suppressed_img(:,:,i) == threshold_img(:,:,i) );
    threshold_img(:,:,i) = suppressed_img(:,:,i);
    
end
figure()
imshow(threshold_img)
title('Non-maxima suppression image')


%%
load createdgroundtruth.mat
%%
T = T(:, {'imageFilename','six','one','zero','Two','Three','Seven','Eight','Four','Nine','Five'});
I = imread(T.imageFilename{1});
I = insertObjectAnnotation(I,'Rectangle',T.six{1},'six','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.one{1},'one','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.zero{1},'zero','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.Two{1},'Two','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.Three{1},'Three','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.Seven{1},'Seven','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.Eight{1},'Eight','LineWidth',8);
I = insertObjectAnnotation(I,'Rectangle',T.Four{1},'Four','LineWidth',8);

figure()
imshow(I)
title('Detected image')


