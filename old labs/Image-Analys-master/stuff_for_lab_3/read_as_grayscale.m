function img = read_as_grayscale(path_to_file)

raw_image = imread(path_to_file);
img = im2double(raw_image);
img = mean(img,3);
imagesc(img), colormap gray;