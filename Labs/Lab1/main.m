clc, close all

% 1.1
test_image = reshape((11:100), 10, 9);
patch1=get_patch(test_image,5,5,3);
%1.2
patch1=get_patch(test_image,5,5,3);
patch2=get_patch(test_image,3,3,2);
% test_image = reshape((11:100), 10, 9);

% 1.4 
result = gaussian_filter(test_image, 3.0);

%1.5
[grad_x, grad_y] = gaussian_gradients(result, 3.0)

% 1.6 plot gradients image 
figure(1)
imagesc(test_image);
axis image
hold on
quiver(grad_x, grad_y);

% 1.7
test_image = reshape((11:100), 10, 9);
histogram = gradient_histogram(grad_x, grad_y);
figure(2)
plot_bouquet(test_image, 1.0)

%% 1.8
centere=[612,800];
radius=197;
region_centres= place_regions(centere,radius); 
img=imread('paper_with_digits.png');
plot_squares(img, region_centres, radius)

%% 1.9



load digits.mat
imag=digits_training(12).image;
lbl=digits_training(12).label;

radius=4;
centere=[50,50];

struc_arry=gradient_descriptor(img,centere,radius);

%% 1.10


load digits.mat
size(digits_training(12).image,1); 

digits_training=prepare_digits(digits_training);


% 1.11

label = classify_digit(digits_training(12).image,digits_training); 

disp(['Image output calassify number is''' num2str(label.address)])
disp(['Image output calassify index is''' num2str(label.index)])
 
%% Ex 1.12 - Validate all digits 
load digits.mat

conceal_digits=classify_all_digits(digits_validation,digits_training);


flag=0; 
for k=1:numel(conceal_digits)
    if(conceal_digits(k).correctly_classified)==1
        flag=flag+1;
    end
end
accuracy= flag/ numel(conceal_digits)*100; 

disp(['Accuracy for digit classification is' ' ' num2str(accuracy) '%'  ])


%% 1.14

load digits.mat

descs_1=digits_training(1).image;

descs_2 = digits_training(2).image;

corrs = matchFeatures(descs_1, descs_2, 'MatchThreshold', 100, 'MaxRatio', 0.7);

%% 1.15 

load church_data.mat

image= imread('church1.jpg');

[label, name] = classify_church(image, feature_collection)


%% 1.16 
clc
load church_test/manual_labels
load church_data.mat
accuracy=0; 
for k=1:10 
    image = imread(['church' num2str(k) '.jpg']); 
    [label, name]= classify_church(image, feature_collection); 
    disp(['itteration' num2str(k) ])
    disp([name,manual_labels(k)])
    
    if ismember(name,manual_labels(k))
        accuracy=accuracy+1; 
        
    end    
end

disp([num2str(accuracy*10) '%' ' ' 'of churches was classified correctly'])
