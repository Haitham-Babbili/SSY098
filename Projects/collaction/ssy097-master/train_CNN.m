%   Train neural network for cell detection                         %
%   Assumes positivePatches.mat & negativePatches.mat is on path    %
%                                                                   %
%   Output: my_network.mat                                          %
%-------------------------------------------------------------------%

clear all

%---------------%
% Load data     %
%---------------%

positive = load('patchesPositive.mat');
negative = load('patchesNegative.mat');

%-----------------------------------------------%
% Create initial training examples & labels     %
%-----------------------------------------------%

Nexamples = 2000;   % Size of example batch (1000 pos/1000 neg)
maxIndex = 5000;    % Use 5000 patches from pos/neg and leave rest for validation
examples = cat(4, positive.patches{1:maxIndex}, negative.patches{1:maxIndex});
labels = [ones(maxIndex,1); zeros(maxIndex,1)];
[imgs_train, labels_cat] = getShuffeledTrainingSet(examples, labels, maxIndex, Nexamples);

%imgs_train = cat(4, positive.patches{1:Nexamples}, negative.patches{1:Nexamples});
%labels = [ones(Nexamples,1); zeros(Nexamples,1)];
 
%--------------------------------------------% 
% Initialize CNN & perorm one training epoch %
%--------------------------------------------%

layers = basic_cnn_classifier();
net = train_classifier(layers, imgs_train, labels_cat);


%---------------------------------------% 
% Perform some more training iterations %
%---------------------------------------%

Nepochs = 15;
for i=i:Nepochs
        
    [imgs_train, labels_cat] = getShuffeledTrainingSet(examples, labels, maxIndex, Nexamples);
    net =  train_classifier(net.Layers, imgs_train, labels_cat);
    
end

%------------------------% 
% Prepare validation set %
%------------------------%

imgs_pos = cat(4, positive.patches{maxIndex:end});
imgs_neg = cat(4, negative.patches{maxIndex:end});

pLen = length(imgs_pos);
nLen = length(imgs_neg);

if pLen > nLen
    imgs_pos = imgs_pos(:,:,:,1:nLen);
    len = nLen;
else
    imgs_neg = imgs_neg(:,:,:,1:pLen);
    len = pLen;
end

imgs_val = cat(4,imgs_pos,imgs_neg);
labels_val = [ones(len,1); zeros(len,1)];
labels_val = categorical(labels_val);

%-------------------%
% Test accuracy     %
%-------------------%

YTest = classify(net, imgs_val);
TTest = labels_val;
accuracy = sum(YTest == TTest)/numel(TTest)
   

save('my_network.mat','net');

%--------------------------------------------% 
% Function to shuffle training data randomly %
%--------------------------------------------%

function [imgs_train, labels_cat] = getShuffeledTrainingSet(examples, labels, maxIndex, Nexamples)

    % Make sure we get 50% positive and 50% negative samples
    posIdx = randperm(maxIndex, Nexamples/2);
    negIdx = randperm(maxIndex, Nexamples/2)+5000;
    temp = [posIdx negIdx];
    indexes = temp(randperm(length(temp)));   
    
    imgs_train = examples(:,:,:,indexes);
    labels_cat = categorical(labels(indexes));
        
end
