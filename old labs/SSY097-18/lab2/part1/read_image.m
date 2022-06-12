function img = read_image(path_to_file)

raw_image = imread(path_to_file);
img = im2double(raw_image);         % Images are usually in uint8. Convert to double [0,1]


end




