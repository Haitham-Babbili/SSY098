function test_image = test_dataset(image)

img = imread(image);    % Read the image
threshold = 70;                   % Define a threshold for converting to black and white
[x,y,z] = size(img);
subplot(1,3,1)
imshow(img)
title('original Image')

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

% Convert to RGB, then resize the image to 28x28
test_image = (rgb2gray(new_image));
subplot(1,3,2)
imshow(test_image)
title('boxed Image');

%detect the number region

leabel_2d = bwlabel(test_image);  % label the connection areas
property = regionprops(leabel_2d,'basic'); % get the basic property of the connected regions
areas = [property.Area]; % get the area of the connected regions
rec_box= cat(1,property.BoundingBox); % concat the boundingBox of the connected areas
[~,max_id] = max(areas); % find the max area of the connected areas
max_rect = rec_box(max_id,:); % the find the boundindBox of the max connected area
centroids = cat(1,property.Centroid); %concat the contoid of the connected areas

% plot(centroids(:,1),centroids(:,2),'b*');

temp =[-120,-50,260,100]; %resize the boundingbox
max_rect = max_rect+temp;     
rectangle('position',max_rect,'EdgeColor','r');

crop_image = imcrop(test_image,max_rect);  % crop the image

test_image = imresize(crop_image,[28,28]);
test_image = test_image(:);
test_image = test_image./max(test_image);
test_image = reshape(test_image,28,28,1,size(test_image,2));

% Show actual image and the processed image

subplot(1,3,3)
imshow(test_image)
title('resized image');


figure(3)
imshow(crop_image)
title('Crop Image');
end

