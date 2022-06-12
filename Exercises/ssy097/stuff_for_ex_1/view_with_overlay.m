function view_with_overlay(img, overlay)

% function view_with_overlay(img, overlay) displays the image img with 
% a yellow overlay. img can be RGB or grayscale.

if max(img(:)>1) || min(img(:)) < 0
    error('img should be scaled between 0 and 1');
end

if size(img,3) < 3
    oimg = img;
    img = zeros(size(img,1), size(img,2), 3);
    img(:,:,1) = oimg;
    img(:,:,2) = oimg;
    img(:,:,3) = oimg;
end

view_image = zeros([size(img,1) size(img,2) 3]);

view_image(:,:,1) = max(img(:,:,1), overlay);
view_image(:,:,2) = max(img(:,:,2), overlay);
view_image(:,:,3) = img(:,:,3);

clf
imagesc(view_image)
axis image