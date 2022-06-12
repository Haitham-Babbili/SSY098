function test_image = test_dataset(image)

img = imread(image);    % Read the image
threshold = 70;         % Define a threshold for converting to black and white
[x,y,z] = size(img);    % specify image cordenate size
subplot(1,4,1)          
imshow(img)
title('Test Image')

% Macke the image match trained data in MNIST by converting the backgrount to black then
%invert the black coler of digit to white in another word apply gray scale
img = double(img);
target_image = zeros(x,y,z);
temp_1 = (img(:,:,1) + img(:,:,2) + img(:,:,3))/3;
temp_2 = temp_1<threshold;

target_image(:,:,1) = 255*double(temp_2);
target_image(:,:,2) = target_image(:,:,1);
target_image(:,:,3) = target_image(:,:,1);

new_image = double(target_image);

% Transfer image to gray mapping
test_image = (rgb2gray(new_image));
subplot(1,4,2)
imshow(test_image)
title('Target Image');

% Get the exacte reigen for the number 
leabel_2d = bwlabel(test_image);           
property = regionprops(leabel_2d,'basic'); 
areas = [property.Area];                   
rec_box= cat(1,property.BoundingBox);      
[~,max_id] = max(areas);                   
boundbox_max = rec_box(max_id,:);          
% center = cat(1,property.Centroid);         


% temp =[-120,-50,260,100];     % bound box size 
temp =eye(2,2);     % bound box size 
boundbox_max = boundbox_max+temp;     
rectangle('position',boundbox_max,'EdgeColor','r');

crop_image = imcrop(test_image,boundbox_max);  % crop the image

test_image = imresize(crop_image,[28,28]);
test_image = test_image(:);
test_image = test_image./max(test_image);
test_image = reshape(test_image,28,28,1,size(test_image,2));

% Show actual image and the processed image

subplot(1,4,3)
imshow(test_image)
title('Result image');


subplot(1,4,4)
imshow(crop_image)
title('Crop Image');

end

