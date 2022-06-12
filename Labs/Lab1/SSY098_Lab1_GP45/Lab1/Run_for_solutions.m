%Our approach is to run the matlab script step-by-step
%Main file for solutions, section by section
clc, close all
clc

% Ex 1.1 First function was created as get_patch.m file
%
% Ex 1.2 ================================================
test_image = reshape((11:100), 10, 9);
patch1=get_patch(test_image,5,5,3);
patch2=get_patch(test_image,3,3,2);
patch3=get_patch(test_image,4,4,1);
patch4=get_patch(test_image,4,4,2);


% Ex 1.3=================================================
%Modification of get_patch file to return 
%"Patch outside image borders". 
%The line below, uncommented, will give the message above
%patch5=get_patch(test_image,5,5,5);
%
% Ex 1.4a=================================================
clc
result = gaussian_filter(test_image, 3.0);
img=imread_grayscale('paper_with_digits.png');
std=4; 
img_gauss=gaussian_filter(img,std);

%%
% Ex 1.4b===Gaussian Filtered Image=======================
% uncomment below and run
% img=imread_grayscale('paper_with_digits.png');
%  result=gaussian_filter(img,3.0);
 
% Ex1.5 =================================================

[grad_x, grad_y] = gaussian_gradients(result, 3.0);


% Ex 1.6 =====================================================
% Plot gradients image 
figure(1)
imagesc(test_image)
axis image
hold on
quiver(grad_x, grad_y)
hold off


figure(2)
imagesc(img)
axis image
hold on
quiver(grad_x, grad_y)
hold off

%%
% Ex 1.7 ========================================================
% 
%test_image = reshape((11:100), 10, 9);

histogram = gradient_histogram(grad_x, grad_y);
% The Plot of the gradient histogram

plot_bouquet(test_image, 3.0)


%% Ex 1.8 ================================================
centre=[612,800];
radius=200;
%img=imread_grayscale('paper_with_digits.png');
img=imread('paper_with_digits.png');
region_centres= place_regions(centre,radius);
%region_centres
plot_squares(img, region_centres, radius)

% Ex 1.9

load digits.mat
imag=digits_training(12).image;
lbl=digits_training(12).label;

radius=4;
centre=[50,50];

struct_array=gradient_descriptor(img,centre,radius);

%% Ex 1.10 ============================================

load digits.mat
size(digits_training(12).image,1); 
digits_training=prepare_digits(digits_training);

% Ex 1.11 ===============================================

label = classify_digit(digits_training(12).image,digits_training); 
disp(['Output Image classified number is''' num2str(label.address)])
disp(['Output Image classified index is''' num2str(label.index)])
 

% Ex 1.12 ==============================================
% Validation of the Digits

load digits.mat
conceal_digits=classify_all_digits(digits_validation,digits_training);
flag=0; 
for k=1:numel(conceal_digits)
    if(conceal_digits(k).correctly_classified)==1
        flag=flag+1;
    end
end
accuracy= flag/ numel(conceal_digits)*100; 

disp(['The Accuracy for digit classification is' ' ' num2str(accuracy) '%'  ])

%% Ex 1.13 =====================================================
% Question requires manipulation of data parameters


%% Ex 1.14 =====================================================
% Testing the SIFT Solution........
% 'MatchThreshold':  a scalar T,such that 0 < T <= 100, which denotes the
%distance threshold required for a match. A pair of
%features are not matched if the distance between
%them is more than the threshold, in %,from a perfect match.

%MaxRatio' :a scalar R,such that 0 < R <= 1, specifying a ratio threshold
%for rejecting uncorrelated matches. R is increased to get better matches
 
load digits.mat

descs_1=digits_training(1).image;

descs_2 = digits_training(2).image;

corrs = matchFeatures(descs_1, descs_2, 'MatchThreshold', 100, 'MaxRatio', 0.7);

% Ex 1.15 =============================================
clc
load church_data.mat

image_out= imread_grayscale('church1.jpg');

[label, name] = classify_church(image_out, feature_collection);



% Ex 1.16 ====================================================
clc
load manual_labels
load church_data.mat
accuracy_calc=0; 
for j=1:10 
    image = imread_grayscale(['church' num2str(j) '.jpg']); 
    [label, name]= classify_church(image, feature_collection); 
    disp(['itteration' num2str(j) ])
    disp([name,manual_labels(j)])
    
    if ismember(name,manual_labels(j))
        accuracy_calc=accuracy_calc+1; 
        
    end    
end

disp([num2str(accuracy_calc*10) '%' ' ' 'of churches was classified correctly'])



