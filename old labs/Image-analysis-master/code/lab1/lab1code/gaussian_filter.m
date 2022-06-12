function output=gaussian_filter(greyscale,std)
% size of filter given
size=4*std;
filter=fspecial('gaussian',[size size],std);
output=imfilter(greyscale,filter,'symmetric');
end