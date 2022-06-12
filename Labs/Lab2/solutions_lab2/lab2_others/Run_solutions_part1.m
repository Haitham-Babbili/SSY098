
%% 2.1 Learning a linear classifier
clear;
clc;
% Ex 2.1 - Load data
 load ('cell_data.mat')
%load stuff_for_lab_2/cell_data.mat;
% positive patches denoted as fg_patches
% negative patches denoted as bg_patches

% Ex 2.2 - Creation of two new variables
% Examples: a cell structure containing the all the patches (both positives and negatives)
fg_cells= cell_data.fg_patches; 
bg_cells= cell_data.bg_patches;
% 

examples={}; 
examples(1:length(fg_cells))= fg_cells; 
examples(length(fg_cells)+1:400)= bg_cells;
% cell_data.examples = zeros(1,length(cell_data.fg_patches)+length(cell_data.fg_patches));
% cell_data.labels = zeros(1,length(cell_data.fg_patches)+length(cell_data.fg_patches));

% (1,400) vector
%cell_data.examples = [cell_data.fg_patches cell_data.bg_patches];

% (1,400) vector
%cell_data.labels = [ones(1,200) zeros(1,200)];

for j= 1: length(fg_cells)
    labels(j)= 1;
end 

for j= (length(fg_cells)+1) : (length(fg_cells) + length(bg_cells))
    labels(j)=0; 
end 

%% 2.3 splitting into training and validataion data 
% distrubution is 50% 25% 25%, between training, testing, validation
% Models with very few hyperparameters will be easy to validate and tune, 
%so you can probably reduce the size of your validation set, but if your 
%model has many hyperparameters, you would want to have a large validation 
%set as well(although you should also consider cross validation).
clc

% Training data, testing data, Validation data

examples_train(1:100)=examples(1:100); % selection of 100 good cells for training
examples_train(101:200)=examples(201:300); % selection of 100 bad cells for training
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


%% 2.4 function partial_gradient.m
%function file for partial_gradient is created, see partial_gradient.m

%% 2.5 function process_epoch.m
%function file for process_epoch is created, see process_epoch.m

% 
% 
%% 2.6 S=0.01
% examplesrand=randperm(length(examples_train));%we want to pick random images for 
% %our gradient descent and therefor we make an array of random numbers with
% %as many numbers as there are pictures
clc
close all 

 s = 0.01; % s={10,1,0.1}
% s=0.1;
% s=1;
% s=10;
w = s * randn(35,35);% a random wighted gray 35,35 img
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
    %plot(w_grad); % Linear plot of the image
    %surf(w_grad); %For Surface plot
    title(' s= 0.01, lrate=0.1')
    %title(' s= 0.1, lrate=0.1')
    %title(' s= 1, lrate=0.1')
    %title(' s= 10, lrate=0.1')
end 

%% 2.6 S=10
% s1 = 0.1; % s={10,1,0.1}
% 
% w = s1 * randn(35,35);% a random wighted gray 35,35 img
% w0 = 0;
% lrate= 0.1; % The steplength for gradient decent
% % Learning rates tested [1 0.5 0.1 0.01 0.001 0.0001]
% w0_grad= []; 
% w_grad= zeros(35,35);
% 
% 
% for j= 1:5
% 
%     [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train); 
%     w_grad= w_grad + w ; 
%     w0_grad= w0_grad + w0;
%     figure(j)
%     %imagesc(w_grad), colormap gray
%     imagesc(w_grad); % Display image
%     %plot(w_grad); % Linear plot of the image
%     %surf(w_grad); %For Surface plot
%     title(' s= 10')
% end 
% 




%% Ex 2.7
% A modification was made in the finction file process_epoch.m

%% Ex 2.8 function for classify.m

%% Ex 2.9 function for augment_data.m
% 
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


%% Ex 2.15a
[imgs, labels] = digitTrain4DArrayData;
layers = better_cnn_classifier();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4940));
labels_train = labels(randimgs(1:4940));
imgs_val = imgs(:,:,:,randimgs(4001:4940));
labels_val = labels(randimgs(4001:4940));

net = train_classifier(layers, imgs_train,... 
     labels_train, imgs_val, labels_val);
 %% No need since classification is 100%
for i=2:3
%net = train_classifier(net.Layers, imgs_train, labels_train, imgs_val, labels_val, i);
%net = train_classifier(net.Layers, imgs_train, labels_train, imgs_val, labels_val, 2);
%net = train_classifier(net.Layers, imgs_train, labels_train, imgs_val, labels_val, 3);
end


%% Ex 2.18

% better_cnn_classifier function
%% Ex 2.19b

[imgs_test, labels_test] = digitTest4DArrayData;

pred = net.classify(imgs_test) == labels_test;

nbrcorr = (sum(pred)/length(imgs_test))*100;

disp([num2str(nbrcorr) '% of the test numbers where classified correctly'])


%% 2.20...not sure it is working

fel = find(pred == 0);

for i=1:5
felbild =fel(i);
mistaken_as = net.classify(imgs_test(:,:,:,felbild));

imwrite(imgs_test(:,:,:,felbild), (['mistaken_as_' char(mistaken_as) '.png']))
end
