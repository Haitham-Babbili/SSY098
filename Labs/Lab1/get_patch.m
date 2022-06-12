function patch = get_patch(image, x, y, patch_radius)


[h,w,l] = size(image); 


if x + patch_radius > w || x - patch_radius < 1
    error ('Patch outside image borders')
elseif y + patch_radius > h || y - patch_radius < 1
    error ('Patch less than image borders')

end

% range of x and y cordinates to pike from input image
X= linspace(x-patch_radius,x+patch_radius,2*patch_radius+1);
Y= linspace(y-patch_radius,y+patch_radius,2*patch_radius+1);


% check if colored or not
%l=3 color
if size(image,3)==3 
    patch=zeros(2*patch_radius+1,2*patch_radius+1,3); %creat new patch with color z =3 
    for n_patch=1:size(patch,3) % repeated for 3 dimensions
        for itr_x = 1:size(patch,1)  % repeat over x-axsis 
            for itr_y= 1:size(patch,1)  % repeat y-axsis
                patch(itr_x,itr_y,n_patch)=image(X(itr_x),Y(itr_y),n_patch);% pring the pixel we want from the imag
            end 
        end 
    end
  %l=1 gray  
else % if the image is not a colorimage then go to the gray image method 
    patch=zeros(2*patch_radius+1); %creat new patch with gray z =1
    for itr_x = 1:size(patch,1) % repeat over x-axsis 
        for itr_y= 1:size(patch,1)  % repeat y-axsis
            patch(itr_x,itr_y)=image(X(itr_x),Y(itr_y));%  pring the pixel we want from the imag
        end 
    end 
end 
    

end

