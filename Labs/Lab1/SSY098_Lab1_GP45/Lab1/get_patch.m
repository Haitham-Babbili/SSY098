function patch = get_patch(image, x, y, patch_radius)
% Input information:
% given image, with x-coordinate, y-coordinate, radius of patch

% Output Information:
% The patch, which is a matrix, specified by x, y, and the radius of the patch
% The looping operation is to track for better accuracy of our finding
% h-height, w-width

[h,w,~] = size(image); 


if x + patch_radius > w || x - patch_radius < 1
    error ('Patch outside image borders')
elseif y + patch_radius > h || y - patch_radius < 1
    error ('Patch less than image borders')

end

% range of x and y coordinates to be picked from input image
X= linspace(x-patch_radius,x+patch_radius,2*patch_radius+1);
Y= linspace(y-patch_radius,y+patch_radius,2*patch_radius+1);


% check if coloured image or gray image
%l=3 color
if size(image,3)==3 
    patch=zeros(2*patch_radius+1,2*patch_radius+1,3); %create a new patch with color z =3 
    for n_patch=1:size(patch,3) % repeated for 3 dimensions
        for itr_x = 1:size(patch,1)  % repeat over x-axsis 
            for itr_y= 1:size(patch,1)  % repeat over y-axsis
                patch(itr_x,itr_y,n_patch)=image(X(itr_x),Y(itr_y),n_patch);% Bring the pixel we want from the given image
            end 
        end 
    end
  %l=1 gray  
else % if the image is not a colorimage then go to the gray image method 
    patch=zeros(2*patch_radius+1); %create a new patch with gray l=1
    for itr_x = 1:size(patch,1) % repeat over x-axsis 
        for itr_y= 1:size(patch,1)  % repeat over y-axsis
            patch(itr_x,itr_y)=image(X(itr_x),Y(itr_y));%  Bring the pixel we want from the given image
        end 
    end 
end 
    

end

