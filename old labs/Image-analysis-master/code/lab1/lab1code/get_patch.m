function patch=get_patch(image,x,y,patch_radius)

x0=x-patch_radius;
x1=x+patch_radius;
y0=y-patch_radius;
y1=y+patch_radius;
max_x=size(image,2);
max_y=size(image,1);
if(x0<=0||y0<=0||x1>max_x||y1>max_y)
    error("Patch not contained within image borders!");
end
z=size(image,3); % deal with multilayer images
patch=zeros(y1-y0+1,x1-x0+1,z);
for k=1:z
   patch(:,:,k)=image(y0:y1,x0:x1,k);
end
end