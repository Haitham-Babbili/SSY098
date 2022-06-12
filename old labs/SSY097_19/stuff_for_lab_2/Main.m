% 2.1 & 2.2 
clc 
close all 
clear all

load cell_data; 

cells= cell_data.fg_patches; 

not_cells= cell_data.bg_patches; 
exampels={}; 
exampels(1:length(cells))= cells; 
exampels(length(cells)+1:400)= not_cells;



for i= 1: length(cells)
    labels(i)= 1;
end 

for k= (length(cells)+1) : (length(cells) + length(not_cells))
    labels(k)=0; 
end 

%% 2.3 splitting into training and validataion data 
% distrubution is 50% 25% 25%, between training, testing, validation
clc

examples_training(1:100)=exampels(1:100); % extracts 100 good cells for training
examples_training(101:200)=exampels(201:300); % extracts 100 bad cells for training
lables_training(1:100)= labels(1:100); 
labels_training(101:200)= labels(201:300); 


examples_test(1:50)=exampels(101:150); % extracts 50 good cells for testing
examples_test(51:100)=exampels(301:350); % extracts 50 bad cells for training
lables_test(1:50)= labels(101:150); 
labels_test(51:100)= labels(301:350); 

examples_val(1:50)= exampels(151:200);% extracts 50 good cells for validataion
examples_val(51:100)=exampels(351:400); % extracts 50 bad cells for training
lables_val(1:50)= labels(151:200); 
labels_val(51:100)= labels(351:400); 

%% 2.4 implemented the partial gradient function     

%% 2.5 implemented the process epoch function 


%% 2.6 
clc
close all 

s = 0.01; 
w = s * randn(35,35);% a random wighted gray 35,35 img
w0 = 0;
lrate= 4; % sets the steplength for the gradient decent
w0_decent= []; 
w_decent= zeros(35,35);


for k= 1:5

    [w, w0] = process_epoch(w, w0, lrate, examples_training, labels_training); 
    w_decent= w_decent + w ; 
    w0_decent= w0_decent + w0;
    figure(k)
    imagesc(w_decent), colormap gray

end 

% imagesc(w_decent), colormap gray









