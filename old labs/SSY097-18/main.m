%% Main-fil
clc
clf
clear 
close all

% -- Load data -- %
positive = load('patchesPositive.mat');
negative = load('patchesNegative.mat');

% -- Create labels. 1 = positive, 0 = negative -- %
labels = [ones(length(positive.patches),1); zeros(length(negative.patches),1)];
labels = categorical(labels);

N = 1000;
imgs_train = cat(4, positive.patches{1:N}, negative.patches{1:N});
layers = basic_cnn_classifier();
net = train_classifier(layers, imgs_train, labels(1:N));

nr_epochs = 5;

for i=1:nr_epochs-1
    imgs_train = cat(4, positive.patches{(i*N)+1:(i+1)*N});
    net =  train_classifier(net.Layers, imgs_train, labels(1:N));        
end

% Create validation set
imgs_pos = cat(4, positive.patches{N*nr_epochs+1:end});
len = length(imgs_pos);
imgs_neg = cat(4, negative.patches{1:len});

imgs_val = cat(4,imgs_pos,imgs_neg);

labels_val = [ones(1,len) zeros(1,len)];
labels_val = categorical(labels_val');

% Test accuracy
YTest = classify(net, imgs_val);
TTest = labels_val;
accuracy = sum(YTest == TTest)/numel(TTest)




%% A.2 Applying your detector
clc
clf
clear
close


img = read_image('dataset/img_4.png');
detections = run_detector(img);

imagesc(img); axis image;
hold on;
plot(detections(1,:), detections(2,:),'r*')



