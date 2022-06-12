
%% 2.1 Learning a linear classifier
clear;
clc;
% Ex 2.1 - Load data
 load ('cell_data.mat')
%load stuff_for_lab_2/cell_data.mat;
% positive patches denoted as fg_patches
% negative patches denoted as bg_patches

%% Ex 2.2 - Creation of two new variables
% % Examples: a cell structure containing the all the patches (both positives and negatives)

examples = [cell_data.fg_patches cell_data.bg_patches];

labels = [ones(length(cell_data.fg_patches),1) zeros(length(cell_data.bg_patches),1)];

%% 2.3 splitting into training and validataion data 
% distrubution is 50% 25% 25%, between training, testing, validation
% Models with very few hyperparameters will be easy to validate and tune, 
%so you can probably reduce the size of your validation set, but if your 
%model has many hyperparameters, you would want to have a large validation 
%set as well(although you should also consider cross validation).
clc

% Training data, testing data, Validation data

examples_train(1:100)=examples(1:100); % selection of 100 positive cells for training
examples_train(101:200)=examples(201:300); % selection of 100 negative cells for training
labels_train(1:100)= labels(1:100); 
labels_train(101:200)= labels(201:300); 


examples_test(1:50)=examples(101:150); % selection of 50 good cells for testing
examples_test(51:100)=examples(301:350); % selection of 50 bad cells for testing
labels_test(1:50)= labels(101:150); 
labels_test(51:100)= labels(301:350); 

examples_val(1:50)= examples(151:200);% selection of 50 good cells for validataion
examples_val(51:100)=examples(351:400); % selection of 50 bad cells for validation
labels_val(1:50)= labels(151:200); 
labels_val(51:100)= labels(351:400);


%% 2.4
%function file for partial_gradient is created, see partial_gradient.m

%% 2.5
%function file for process_epoch is created, see process_epoch.m


%% 2.6
% examplesrand=randperm(length(examples_train));%we want to pick random images for 
% %our gradient descent and therefor we make an array of random numbers with
% %as many numbers as there are pictures
clc
close all 

s = 0.01;
% s=0.1;
% s=1;
% s=10;

w = s .* randn(35,35);% a random wighted gray 35,35 img
% w=s(i) .* linspace(-35,35,35,35);
w0 = 0;
lrate= 0.1; % The steplength for gradient decent
% Learning rates tested [1 0.5 0.1 0.01 0.001 0.0001]
w0_grad= []; 
w_grad= zeros(35,35);


for j= 1:5

    [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train); 
    w_grad= w_grad + w ; 
    w0_grad= w0_grad + w0;
    figure(j)
    %imagesc(w_grad), colormap gray
    imagesc(w_grad); % Display image
%     plot(w_grad); % Linear plot of the image
    %surf(w_grad); %For Surface plot
     title(' s= 0.01, lrate=0.1')
end 


%% Ex 2.7
% A modification was made in the finction file process_epoch.m
 

s = 0.01; % s={10,1,0.1}
% s=0.1;
% s=1;
% s=10;

w = s .* randn(35,35);% a random wighted gray 35,35 img
w0 = 0;
lrate= 0.1; % The steplength for gradient decent
% Learning rates tested [1 0.5 0.1 0.01 0.001 0.0001]
w0_grad= []; 
w_grad= zeros(35,35);


for j= 1:5

    [w, w0] = process_epoch2(w, w0, lrate, examples_train, labels_train); 
    w_grad= w_grad + w ; 
    w0_grad= w0_grad + w0;
    figure(j)
    %imagesc(w_grad), colormap gray
    imagesc(w_grad); % Display image
%     plot(w_grad); % Linear plot of the image
    %surf(w_grad); %For Surface plot
    title(' s= 0.01, lrate=0.1')
end 


%% 2.8
%% 2.9

[examples_train_aug,labels_train_aug]= augment_data(examples_train,labels_train,1)


%% Ex 2.10 
[imgs, labels] = digitTrain4DArrayData;
imagesc(imgs(:,:,:,342)), axis image, colormap gray
layers = [
imageInputLayer([35 35 1]);
fullyConnectedLayer(1);
softmaxLayer();
classificationLayer()];

%% Ex 2.11 function: layers = basic_cnn_classifier()

%% Ex 2.12

options = trainingOptions('sgdm');
layers = basic_cnn_classifier();
net = trainNetwork(imgs, labels, layers, options);

%% Ex 2.13
img=imgs(:,:,:,1);

net.predict(img)
net.classify(img)

%% Ex 2.14
%how many trainable parameters does your network contain?

%% Ex 2.15

[imgs, labels] = digitTrain4DArrayData;
layers = basic_cnn_classifier();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4750));
labels_train = labels(randimgs(1:4750));
imgs_val = imgs(:,:,:,randimgs(4001:4750));
labels_val = labels(randimgs(4001:4750));

net = train_classifier(layers, imgs_train,labels_train, imgs_val, labels_val);

% for i=2:3
% net = train_classifier(net.Layers, imgs_train, labels_train, imgs_val, labels_val, i);
% end

%% 2.16

tic
convolution2dLayer(5, 10);% Elapsed time is 0.003789 seconds.
toc

tic
convolution2dLayer(5, 20);% Elapsed time is 0.003611 seconds. 
toc

%% 2.17

[imgs, labels] = digitTrain4DArrayData;
layers = basic_cnn_classifier_2l();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4750));
labels_train = labels(randimgs(1:4750));
imgs_val = imgs(:,:,:,randimgs(4001:4750));
labels_val = labels(randimgs(4001:4750));

net = train_classifier(layers, imgs_train,labels_train, imgs_val, labels_val);

%% Ex 2.18

[imgs, labels] = digitTrain4DArrayData;
layers = better_cnn_classifier();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4750));
labels_train = labels(randimgs(1:4750));
imgs_val = imgs(:,:,:,randimgs(4001:4750));
labels_val = labels(randimgs(4001:4750));

net = train_classifier(layers, imgs_train,labels_train, imgs_val, labels_val);

% better_cnn_classifier function
%% Ex 2.19

[imgs_test, labels_test] = digitTest4DArrayData;

pred = net.classify(imgs_test) == labels_test;

class_percent = (sum(pred)/length(imgs_test))*100;

disp([num2str(class_percent) '% was classified accurately'])


%% 2.20...not sure it is working

failure = find(pred == 0);

for i=1:5

mistaken_as = net.classify(imgs_test(:,:,:,failure(i)));

imwrite(imgs_test(:,:,:,failure(i)), (['mistaken_as_' char(mistaken_as) '.png']))

end




