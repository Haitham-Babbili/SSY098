% 1.2 
clc, close all 
test_image = reshape((11:100), 10, 9);

test1= get_patch(test_image,4,4,1);

test2= get_patch(test_image,4,4,2);

%% 1.4 testing the gaussian function
clc, close all 

img=img_read_gray('lemon.png');
std=2; 
img_gauss=gaussian_filter(img,std); 

%% 1.5 gaussian derrivatives / gaussian gradients 
clc, close all 

img=img_read_gray('lemon.png');

[x,y]=gaussian_gradients(img,std); 

% 1.6 plotting gradients over img 
clc , close all 
imagesc(img), colormap gray
axis image
hold on
quiver(x, y)


%% 1.7 
clc , close all 
img=img_read_gray('lemon.png');
std=2; 
plot_bouquet(img,std)

%% 1.8 
clc, close all 
centere=[50,50];
radius=2;
img=img_read_gray('lemon.png');

region_centres= place_regions(centere,radius); 
region_centres
plot_squares(img, region_centres, radius)

%% 1.9
clc, close all
img=img_read_gray('lemon.png');
radius=1;
centere=[50,50];

tmp=gradient_descriptor(img,centere,radius);



%% 1.10 DIGIT CLASSIFICATION 
clc
load digits.mat
size(digits_training(1).image,1); 

digits_training=prepare_digits(digits_training);

% 1.11 
clc

digits_classified= classify_digit(digits_validation(2).image,digits_training); 

disp(['Imput image calassified as number' ' ' num2str(digits_classified.label)])

%% 1.12 
clc, clear all 
load digits.mat

all_digits_classified=classify_all_digits(digits_validation,digits_training);


sum=0; 
for k=1:numel(all_digits_classified)
    if all_digits_classified(k).correctly_classified==1
        sum=sum+1;
    end
end
accuracy= sum/ numel(all_digits_classified)*100; 

disp(['Accuracy for digit classification is' ' ' num2str(accuracy) '%'  ])
% är 78% ett sjysst värde? 

%% 1.14 SIFT 

% 'MatchThreshold'   A scalar T, 0 < T <= 100, that specifies the
                       %distance threshold required for a match. A pair of
                       %features are not matched if the distance between
                       %them is more than T percent from a perfect match.

%MaxRatio'         A scalar R, 0 < R <= 1, specifying a ratio threshold
                       %for rejecting ambiguous matches. Increase R to
                       %return more matches.
                       
load digits.mat
descs_1= digits_training(1).image; 
descs_2 = digits_training(2).image;

corrs = matchFeatures(descs_1, descs_2, 'MatchThreshold', 100, 'MaxRatio', 0.7);

%% 1.15 
clc
load church_data.mat

image2= img_read_gray('church1.jpg');

[label, name] = classify_church(image2, feature_collection)


%% 1.16 
clc
load manual_labels
load church_data.mat
accuracy=0; 
for k=1:10 
    image = img_read_gray(['church' num2str(k) '.jpg']); 
    [label, name]= classify_church(image, feature_collection); 
    disp(['itteration' num2str(k) ])
    disp([name,manual_labels(k)])
    
    if ismember(name,manual_labels(k))
        accuracy=accuracy+1; 
        
    end    
end

disp([num2str(accuracy*10) '%' ' ' 'of churches was classified correctly'])





