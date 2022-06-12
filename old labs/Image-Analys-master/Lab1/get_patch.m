function patch = get_patch(image, x, y, patch_radius)
%the get_patch function gives a patch from an image. x and y are pixel 
%coordinates for the cener of the patch and the patch_radius defines the  
%dictance from patch center to patch edge.


msg1 = ('the patch reaches outside the image border, change your x,y or patch_radius');
msg2 = ('the patch reaches outside the image border, change your y or patch_radius');
% if patch_radius > x | patch_radius > y
%     %checks if patch_radius is grater then x or y if that is the case an
%     %error message is printed. What if we are over to the very left or 
%     %bottom and choose an radius that is smaller then x or y,
%     %will end up outside image but with no warning. 
%     error(msg)
% end

%change if statement to
width=length(image(1,:));
height=length(image(:,1));
if patch_radius + x > width || x - patch_radius < 1
    error(msg1)

elseif patch_radius + y > height || y - patch_radius < 1
    error(msg2)
    
    else
   patch = image(y-patch_radius:y+patch_radius,x-patch_radius:x+patch_radius);
   %sets patch equal to the part of the image specified by x,y and
   %patch_radius
end



