%% 2.1
load cell_examples.mat %It loads a cell array,examples
%, with all the example images, and an array labels with the labels 
%(1 meanscell and 0 means anything else).

%% 2.2

cell = examples{1,1};% loads example with label 1 = cell
notcell = examples{1,11671};% loads example with label 0 = notcell

figure(1)
imagesc(cell)%shows the picutre of a cell(foreground) 
figure(2)
imagesc(notcell)%shows the picture of no cell(background)

%% 2.3
%function for partial_gradient is created, see partial_gradient.m

%% 2.4
%function for process_epoch is created, see process_epoch.m

%% 2.5
load cell_examples.mat
examplesrand=randperm(length(examples));%we want to pick random images for 
%our gradient descent and therefor we make an array of random numbers with
%as many numbers as there are pictures
w = 0.01 * randn(29,29,3);% creates a random weighted image 
w0 = 0;
lrate=0.01; % sets learningrate to 0.01(how big steps we take in the 
%gradient direction)

for i=1:5 %does five epochs
    ii=examplesrand(i); %goes through the 5 first numbers from the 
                        %random random array and sets ii equal to that image
example = examples{1,ii};%picks a random image from the examples cell 
label = labels(ii); %sets label equal to the label of the random image we 
%have picked 

[w, w0] = process_epoch(w, w0, lrate, example, label);

end

imagesc(w) %gives us the weighted image after 5 epochs

%% 2.7

%for i=1:3
    img= read_image(['cells-test/042.png']);
    probmap = sliding_window(img, w, w0);
    show_with_overlay(img, probmap>0.5)
%end

%% 2.8

threshold = 0.5;
gaussian_std = 3;

maxima = strict_local_maxima(probmap, threshold, gaussian_std);

imagesc(img); colormap gray; axis image;
hold on;
plot(maxima(1,:), maxima(2,:),'r*')

%% 2.9

[imgs, labels] = digitTrain4DArrayData;

imagesc(imgs(:,:,:,342)), axis image, colormap gray

%% 2.10
%see the function basic_cnn_classifier

%% 2.11

options = trainingOptions('sgdm');
layers = basic_cnn_classifier();
net = trainNetwork(imgs, labels, layers, options);

%% 2.12
img=imgs(:,:,:,1);

net.predict(img)
net.classify(img)

%% 2.13
%how many trainable parameters does your network contain?

%% 2.14
%4/5 as training and use the last 1/5 for validation av trained cnn
layers = basic_cnn_classifier();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4000));
labels_train = labels(randimgs(1:4000));
imgs_val = imgs(:,:,:,randimgs(4001:4940));
labels_val = labels(randimgs(4001:4940));

net = train_classifier(layers, imgs_train,... 
    labels_train, imgs_val, labels_val)

%% 2.15

%For the network below, compare (roughly) the time consumption of the blue 
%and the red.

%% 2.16 
[imgs, labels] = digitTrain4DArrayData;
layers = better_cnn_classifier();
randimgs = randperm(length(imgs));
imgs_train = imgs(:,:,:,randimgs(1:4940));
labels_train = labels(randimgs(1:4940));
imgs_val = imgs(:,:,:,randimgs(4001:4940));
labels_val = labels(randimgs(4001:4940));

net = train_classifier(layers, imgs_train,... 
     labels_train, imgs_val, labels_val, 1)
for i=2:3
net = train_classifier(net.Layers, imgs_train, labels_train, imgs_val, labels_val, i)
end

%% 2.17

[imgs_test, labels_test] = digitTest4DArrayData;

truelabel2 = net.classify(imgs_test) == labels_test;

nbrcorr1 = (sum(truelabel2)/length(imgs_test))*100;

disp([num2str(nbrcorr1) '% of the test numbers where classified correctly'])

%% 2.18

fel = find(truelabel2 == 0);

for i=1:5
felbild =fel(i);
mistaken_as = net.classify(imgs_test(:,:,:,felbild));

imwrite(imgs_test(:,:,:,felbild), (['mistaken_as_' char(mistaken_as) '.png']))
end
