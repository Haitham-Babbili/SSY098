clear all;
close all;
clc;


%2.1
load cell_data.mat;

%2.2
examples = [cell_data.fg_patches cell_data.bg_patches];

labels = [ones(length(cell_data.fg_patches),1); zeros(length(cell_data.bg_patches),1)];

% for i=1:length(examples)
%     if examples(i)== cell_data.bg_patches;
%         leble(i)=0;
%     elseif examples(i)== cell_data.fg_patches;
%         leble(i)=1;
%     end
% end
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


%% 2.4
%function file for partial_gradient is created, see partial_gradient.m



