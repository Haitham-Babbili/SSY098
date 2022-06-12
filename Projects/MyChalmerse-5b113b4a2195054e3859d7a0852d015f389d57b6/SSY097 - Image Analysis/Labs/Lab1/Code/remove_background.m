function [ img_bt, img_bw ] = remove_background( image )
%REMOVE_BACKGROUND Remove image background to make digits clearer, obtain
%binary image which will be used in next operation to extract digits in the
%image.
%   Input arguments:
%   - image : the image which needs to be processed
%   Outputs:
%   - img_bt : the input image is removed background, which is in grayscale
%   - img_bw : binary image consists of only 1 and 0 values, it will be
%   used to find all digits in next step
% Author: Qixun Qu

% Inverse the image, background is converted to dark region, the value of 
% forground object (digits) will have high values.
img_inv = 1 - rgb2gray(image);

% Normalize the inversed image, in this case, it is able to give the image
% a little bit higher constrast to make digits more clearer.
img_max = max(max(img_inv));
img_min = min(min(img_inv));
img_nor = (img_inv - img_min) / (img_max - img_min);

% Remove background of the image to reserve digits
% it can be observed that there is uneven illumination in the image
kw = 9;
% First, using minimum filter to get background and remove forground
img_bk = ordfilt2(img_nor, 1, ones(kw), 'symmetric');
% Then, using median filter to make the background point more uniform with
% its neighboors
img_bk = ordfilt2(img_bk, 5, ones(kw), 'symmetric');

% Subtract the background from normalized image, so that the background
% value is much lower than the foreground
img_rbk = imsubtract(img_nor, img_bk);

% Binarize the image that has been removed background, the background value
% will be 0, all the foreground values are 1 now
% The result img_bw is used in next step (not in this function) with the
% built-in function bwlabel(), bwlabel() is able to get connected regions
% whose value is 1 in each region point
img_bw = imbinarize(img_rbk, 0.5);

% Invers the image that has been removed background, after this step, the
% background of img_bt is 1, the foreground of img_bt is in grayscale
% so the img_bt is very similar to images in the training set, it may
% imncrease identification accuracy
img_bt = 1 - (img_rbk .* img_bw);

end