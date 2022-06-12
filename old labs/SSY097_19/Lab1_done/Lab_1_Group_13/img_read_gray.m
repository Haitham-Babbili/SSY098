function [c_mean]= img_read_gray(path)
% - INPUT 
% path to file
% 
% - OUTPUT
% image in grey

raw_image=imread(path);
imreaddouble = im2double(raw_image);
c_mean=mean(imreaddouble,3);
% imagesc(c_mean), colormap gray

end

