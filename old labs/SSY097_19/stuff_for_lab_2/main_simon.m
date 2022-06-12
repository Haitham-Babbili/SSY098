%% Ex 2.1 - Load cell_data

load stuff_for_lab_2/cell_data.mat;

% Struct with
% fg_patches (positive examples) and
% bg_patches (negative examples)

%% 2.2 - Create examples and labels

% cell_data.examples = zeros(1,length(cell_data.fg_patches)+length(cell_data.fg_patches));
% cell_data.labels = zeros(1,length(cell_data.fg_patches)+length(cell_data.fg_patches));

% (1,400) vector
cell_data.examples = [cell_data.fg_patches cell_data.bg_patches];

% (1,400) vector
cell_data.labels = [ones(1,200) zeros(1,200)];

%% 2.3 Creating traning and validation vectors

for i = 1:50
%   50 positive, 50 negative = 100
    cell_data.examples_train(i) = cell_data.examples(i);
    cell_data.examples_train(i+50) = cell_data.examples(i+200);
    cell_data.labels_train(i) = cell_data.labels(i);
    cell_data.labels_train(i+50) = cell_data.labels(i+200);
end

for i = 1:150
%   150 positive, 150 nevative = 300
    cell_data.examples_val(i) = cell_data.examples(i+50);
    cell_data.examples_val(i+150) = cell_data.examples(i+250);
    cell_data.labels_val(i) = cell_data.labels(i+50);
    cell_data.labels_val(i+150) = cell_data.labels(i+250);
end

%% Creating partial_gradient

% partial_gradient(w, w0, example_train, labels_train);
w = cell_data.examples_train(1);
% w0 = ones(35,35);
w0 = 1;
[wgrad,w0grad]=partial_gradient(cell2mat(w), w0, cell_data.examples_train(1), cell_data.labels_train(1));

%% Creating process_epoch
clc
close all
% w = cell2mat(cell_data.examples_train());
w0 = 0;
lrate = 0.5;
examples_train = cell_data.examples_train;
labels_train = cell_data.labels_train;
wfinal=0;
w0final=0;

% use this for plotting 2.6 with different values of s 
% s=[10 1 0.1 0 ];
% for i= 1: numel(s) 
% 
% w = s(i) * randn(35);
%     for k = 1:75
%         [w,w0] = process_epoch(w, w0, lrate, examples_train, labels_train);
%         wfinal = wfinal+w;
%         w0final = w0final+w;
%         %     figure
%         %     imagesc(w), colormap gray
%     end
% figure
% imagesc(w), colormap gray
% title([' s= ' , num2str(s(i))])
% end 

s= 0.001;
w = s * randn(35);
    for k = 1:75
        [w,w0] = process_epoch(w, w0, lrate, examples_train, labels_train);
        wfinal = wfinal+w;
        w0final = w0final+w;
        %     figure
        %     imagesc(w), colormap gray
    end
imagesc(w)

%% 2.7 

% go to process_ epoch and flip the rand to linspace 

%% 2.8 predicted_labels = classify(examples_val,w,w0);

