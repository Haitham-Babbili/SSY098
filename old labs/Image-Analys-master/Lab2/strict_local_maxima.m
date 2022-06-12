function maxima = strict_local_maxima(probmap, threshold, gaussian_std)

gaussianpm = gaussian_filter(probmap,gaussian_std);

image2 = ordfilt2(gaussianpm,9,true(3),'symmetric');%filters the 
%gaussian probability map

gaussianpmth = gaussianpm > threshold;%sets all values of the gaussian 
%probability map grater then the threshold to 1 and all other values 0

equalval = (image2 == gaussianpm);%sets all values that are equal to 1 
%after filtering and before filtering equal
indicator = ( equalval & gaussianpmth);%and operation of the two to get rid 

[row_coords, col_coords] = find(indicator == 1);%gives us the row and
%column where indicator is equal to 1

maxima = [col_coords'; row_coords'];

end