function [patch]= get_patch(image, x, y, patch_radius);
% - INPUT 
% image, x-coordinate, y-coordinate, raius of patch
% 
% - OUTPUT
% the patch (a matrix) specified by x, y, and the radius of the patch

% while loop to catch input errors and to give the abiity to make
% corrections, could be made simpler but works 
while (patch_radius > size(image,2) | patch_radius > size(image,1) | patch_radius < 1 | x-patch_radius <= 0 | x+patch_radius > size(image,1)| y-patch_radius <= 0| x+patch_radius > size(image,1)) == 1  % checks so that the patch fits in the image with the chosen x         
    warning('patch out of bounds');
%             error('patch out of bounds')
            disp('Change x,y, or patch_radius to make sure the whole patch is in the image')
            disp('size of input image')
            disp( size(image)) 
            x = input('new x = ');
            y = input('new y = ');
            patch_radius=input('new patch_radius = ');
end 

all_x=linspace(x-patch_radius,x+patch_radius,2*patch_radius+1); % sets the range of x & y coordinates to pick from the input image
all_y=linspace(y-patch_radius,y+patch_radius,2*patch_radius+1);


% if the image is a colorimage
if size(image,3)==3 
    patch=zeros(2*patch_radius+1,2*patch_radius+1,3); %build the patch with three dim (color)
    for kk=1:size(patch,3) % itterates through the 3 color dimensions
        for ii = 1:size(patch,1)  % itterates throught wanted x-coordinates 
            for jj= 1:size(patch,1)  % itterates throught wanted y-coordinates
                patch(ii,jj,kk)=image(all_x(ii),all_y(jj),kk);% extracts the wanted pixels from the input image to the patch
            end 
        end 
    end
    
else % if the image is not a colorimage then go to the gray image method 
    patch=zeros(2*patch_radius+1); %build the patch in 1 dim 
    for ii = 1:size(patch,1) % itterates throught wanted x-coordinates
        for jj= 1:size(patch,1)  % itterates throught wanted y-coordinates
            patch(ii,jj)=image(all_x(ii),all_y(jj));% extracts the wanted pixels from the input image to the patch
        end 
    end 
end % end of if statement

% disp('Function excecuted with no errors')
end % end function 






