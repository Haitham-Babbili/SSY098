% Group 45
%% Ex 2.1 Learning a linear classifier
close all;
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

%% Ex 2.3 splitting into training and validataion data 
% distribution is 50% 25% 25%, between training, testing, validation
% This should give us the best result
% Training data (50%), Validation data (25%), Testing Data (25%)
%cross-validation of 75%-25%
clc

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


%% Ex 2.4
%function file for partial_gradient is created, see partial_gradient.m

%% Ex 2.5
%function file for process_epoch is created, see process_epoch.m


%% Ex 2.6

clc
close all 

s = 0.01;
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


%% Ex 2.8

% predicted_labels = classify(examples_val,w,w0);

examples_train(1:100)=examples(1:100); 
examples_train(101:200)=examples(201:300); 
labels_train(1:100)= labels(1:100); 
labels_train(101:200)= labels(201:300);
examples_val(1:50)= examples(151:200);
examples_val(51:100)=examples(351:400);
labels_val(1:50)= labels(151:200); 
labels_val(51:100)= labels(351:400);
index = randperm(length(examples_train));
examples_train = examples_train(index);
labels_train = labels_train(index);
index = randperm(length(examples_val));
examples_val = examples_val(index);
labels_val = labels_val(index);
lrate= 0.1;
k = 1;
num = 30; % number of test iterations
accurate_percent = zeros(1,num);
while k < num
    w = 0.01 * randn(35,35);
    w0 = 0;
    epochs = 100;
    for j=1:epochs
        [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train);
    end
    
    predicted_labels = classify(examples_val,w,0);
    accurate = 0;% starting with zero accuracy
    for i=1:length(examples_val)
        if predicted_labels(i) == labels_val(i), accurate = accurate +1;
        end
    end
    accurate_percent(k) = (accurate/length(examples_val))*100;
    k = k + 1;
end
max_accurate = max(accurate_percent);


%% Ex 2.9

%[examples_train_aug,labels_train_aug] = augment_data(examples_train,labels_train,M);
%random permuation gives better accuracy
M = 4; % Make Number of M rotations = 4. It was randomly selected.


examples_train(1:100)=examples(1:100); 
examples_train(101:200)=examples(201:300); 
labels_train(1:100)= labels(1:100); 
labels_train(101:200)= labels(201:300);
examples_val(1:50)= examples(151:200);
examples_val(51:100)=examples(351:400);
labels_val(1:50)= labels(151:200); 
labels_val(51:100)= labels(351:400);
[examples_train_aug,labels_train_aug] = augment_data(examples_train,labels_train,M);
index = randperm(length(examples_train_aug));
examples_train_aug = examples_train_aug(index);
labels_train_aug = labels_train_aug(index);
index = randperm(length(examples_val));
examples_val = examples_val(index);
labels_val = labels_val(index);
lrate= 0.001;% learning rate of 0.001 was used

k = 1;
correct_percentage = zeros(1,num);
while k < num
    w = 0.01 * randn(35,35);
    w0 = 0;
    epochs = M*100;
    for j=1:epochs
        [w, w0] = process_epoch(w, w0, lrate, examples_train_aug, labels_train_aug);  
    end
    
    predicted_labels = classify(examples_val,w,0);
    accurate = 0; % starting with zero accuracy
    for i=1:length(examples_val)
        if predicted_labels(i) == labels_val(i), accurate = accurate +1;
        end
    end
    accurate_percent(k) = (accurate/length(examples_val))*100;
    k = k + 1;
end
max_accurate = max(accurate_percent);


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
img=imgs(:,:,:,1);% from the 4th dimension
net.predict(img)
net.classify(img)

%% Ex 2.14
%how many trainable parameters does your network contain?
%There are 13 layers that are trainable.

%% Ex 2.15

[imgs, labels] = digitTrain4DArrayData;
layers = basic_cnn_classifier();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4750));
labels_train = labels(randimgs(1:4750));
imgs_val = imgs(:,:,:,randimgs(4001:4750));
labels_val = labels(randimgs(4001:4750));

net = train_classifier(layers, imgs_train,labels_train, imgs_val, labels_val);



%% Ex 2.16...Compare roughly....

tic
convolution2dLayer(5, 10);% Elapsed time is 0.003789 seconds.
                          % Elapsed time is 0.019017
toc

tic
convolution2dLayer(5, 20);% Elapsed time is 0.003611 seconds. 
                          % Elapsed time is 0.012646 seconds.
toc

%Tic-toc approach was used to calculate how fast the set-up works. 
%The parameters of the red layer are more than the blue layer. 
%The red layer appears to be faster in processing than the blue layer.

%% Ex 2.17

[imgs, labels] = digitTrain4DArrayData;
layers = basic_cnn_classifier_2l();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4750));
labels_train = labels(randimgs(1:4750));
imgs_val = imgs(:,:,:,randimgs(4001:4750));
labels_val = labels(randimgs(4001:4750));

net = train_classifier(layers, imgs_train,labels_train, imgs_val, labels_val);

% Lower percentage in classification
%% Ex 2.18  better_cnn_classifier function

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

class_percent = (sum(pred)/length(imgs_test))*100; %percentage calculation

disp([num2str(class_percent) '% was classified accurately'])


%% Ex 2.20
% Save three of the failure cases with names indicating what digit they were mistaken for. Include
% these in your submission.

failure = find(pred == 0);

for i=1:5

mistaken_as = net.classify(imgs_test(:,:,:,failure(i)));

imwrite(imgs_test(:,:,:,failure(i)), (['mistaken_as_' char(mistaken_as) '.png']))

end




