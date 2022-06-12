%% Part 1
clc
clf
clear
close 

load cell_examples.mat; 




w = 0.01 * randn(29,29,3);
w0 = 0;
lrate = 0.01;

std = 3;
threshold = 0.45;



[w, w0] = process_epoch(w, w0, lrate, examples, labels);


img = read_image('cells-test/041.png'); 
probmap = sliding_window(img, w, w0);

% show_with_overlay(img,probmap>0.5)
maxima = strict_local_maxima(probmap, threshold, std);

imagesc(img); colormap gray; axis image;
hold on;
plot(maxima(1,:), maxima(2,:),'r*')


    
    
    




