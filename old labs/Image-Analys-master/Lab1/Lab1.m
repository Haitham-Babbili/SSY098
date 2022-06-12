% 1.1

function patch = get_patch(image, x, y, patch_radius)

patch = image(y-patch_radius:y+patch_radius,x-patch_radius:x+patch_radius);


%% 1.2

test_image = reshape((11:100), 10, 9)

get_patch(test_image,3,3,2)

%% 1.3

% function patch = get_patch(image, x, y, patch_radius)
% 
% 
% msg = ('the patch reaches outside the image border, change your x, y or patch_radius');
% 
% if patch_radius > x | y
%     error(msg)
% end
% 
% patch = image(y-patch_radius:y+patch_radius,x-patch_radius:x+patch_radius);

%% 1.4

% function result = gaussian_filter(img, SIGMA);
% 
% ISIZE = size(img);
% HSIZE = [ISIZE(1), ISIZE(2)];
% h = fspecial('gaussian', HSIZE, SIGMA);
% 
% result = imfilter(img, h,'symmetric');

%% 1.5

% function [grad_x, grad_y] = gaussian_gradients(img, std)
% 
% blurimg = gaussian_filter(img, std);
% 
% [grad_x, grad_y] = gradient(blurimg);

%% 1.6
img = read_as_grayscale('church1.jpg');

[grad_x, grad_y] = gaussian_gradients(img, 3);

imagesc(img)
axis image
hold on
quiver(grad_x, grad_y)

%% 1.7

% function histogram = gradient_histogram(grad_x, grad_y)
% 
% angel = atan2(grad_y, grad_x);
% 
% a1 = find( 0 < angel & angel <= pi/4);
% b1 = find((pi/4) < angel & angel <= 2*(pi/4));
% c1 = find(2*(pi/4) < angel & angel <= 3*(pi/4));
% d1 = find(3*(pi/4) < angel & angel <= pi);
% 
% a2 = find( -pi/4 <= angel & angel < 0);
% b2 = find( -(pi/4)*2 <= angel & angel < -pi/4);
% c2 = find( -(pi/4)*3 <= angel & angel < -(pi/4)*2);
% d2 = find( -(pi/4)*4 <= angel & angel < -(pi/4)*3);
% 
% magnitud = zeros(8,1);
% for i=1:length(a1)
%     q1 = a1(i);
%   magnitud(1) = magnitud(1) + sqrt(((grad_y(q1))^2)+((grad_x(q1))^2));
% end
% 
% for i=1:length(b1)
%     q2 = b1(i);
%   magnitud(2) = magnitud(2) + sqrt(((grad_y(q2))^2)+((grad_x(q2))^2));
% end
% 
% for i=1:length(c1)
%     q3 = c1(i);
%   magnitud(3) = magnitud(3) + sqrt(((grad_y(q3))^2)+((grad_x(q3))^2));
% end
% 
% for i=1:length(d1)
%     q4 = d1(i);
%   magnitud(4) = magnitud(4) + sqrt(((grad_y(q4))^2)+((grad_x(q4))^2));
% end
% 
% for i=1:length(a2)
%     q5 = a2(i);
%   magnitud(5) = magnitud(5) + sqrt(((grad_y(q5))^2)+((grad_x(q5))^2));
% end
% 
% for i=1:length(b2)
%     q6 = b2(i);
%   magnitud(6) = magnitud(6) + sqrt(((grad_y(q6))^2)+((grad_x(q6))^2));
% end
% 
% for i=1:length(c2)
%     q7 = c2(i);
%   magnitud(7) = magnitud(7) + sqrt(((grad_y(q7))^2)+((grad_x(q7))^2));
% end
% 
% for i=1:length(d2)
%     q8 = d2(i);
%   magnitud(8) = magnitud(8) + sqrt(((grad_y(q8))^2)+((grad_x(q8))^2));
% end
% 
% histogram = magnitud;

%% 1.8

% function region_centres = place_regions(centre, radius)
% 
% y = centre(1);
% x = centre(2);
% 
% centers_y = [ y-2*radius, y-2*radius, y-2*radius, y, y, y, y+2*radius, y+2*radius,y+2*radius];
% centers_x = [ x-2*radius, x, x+2*radius, x-2*radius, x, x+2*radius, x-2*radius, x, x+2*radius];
% 
% region_centres=[centres_y; centres_x];

%% 1.9

% function desc = gradient_descriptor(image, position, radius)
% 
% histogram72 = zeros(8,9);
% std = radius/10;
% region_centres = place_regions(position, radius);
% 
%     for i=1:9
%         patch = get_patch(image, region_centres(1,i), region_centres(2,i), radius);
% 
%         [grad_x, grad_y] = gaussian_gradients(patch, std);
% 
%         histogram = gradient_histogram(grad_x, grad_y);
% 
%         histogram72(:,i) = histogram;
% 
%     end
% end

%% 1.10

% load digits.mat
% 
% function digits_training = prepared_digits(digits_training)
% 
%     for i=1:length(digits_training)
%         digits_training(i).descriptor = gradient_descriptor(digits_training(i).image, [20, 20], 39)
%     end
% end

%% 1.11

% function label = classify_digit(digit_image, digits_training)
%     
%     whatdigit = gradient_descriptor(digit_image, [20, 20], 6);
%     digits_training = prepared_digits(digits_training);
%     
%     pyt = 0;
%     age = 11;
%     
%     for i=2:length(digits_training)
%        pyt1 = sum(abs((whatdigit)-(digits_training(i).descriptor)));
%        pyt2 = sum(abs((whatdigit)-(digits_training(i-1).descriptor)));
%        if pyt1 < pyt2
%            age = digits_training(i).label;
%        else
%            age = digits_training(i-1).label;
%        end
%     end
%     
%     label = age;
%     
%     disp(['I am ' num2str(age) ' years old'])
% end

%% 1.14
% Lowe ratio criterion: (distance to best match)/(distance to next best match) < tau
% 
% descs_1 = digits_training(1).image;
% descs_2 = digits_training(2).image;
% corrs = matchFeatures(descs_1, descs_2, 'MatchThreshold', 100, 'MaxRatio', 0.7);
%           
% %%
% load church_data
% 
% %first church feature_collection.descriptors(:,1)
% 
% function [label, name] = classify_church(image, feature_collection)
% 
% [coords, descriptors] = extractSIFT(image);
% nrofcorrs = 0;
% 
% for i=1:length(descriptors)
%     for j=1:length(feature_collection.descriptors)
%     corrs = matchFeatures(descriptors(:,i), feature_collection.descriptors(:,j), 'MatchThreshold', 100, 'MaxRatio', 0.7);
%     if length(corrs) > nrofcorrs
%         label = feature_collection.label(j);
%         name = feature_collection.name(label)
%     end
%     end
% end
% 
% end
%         
        
        
