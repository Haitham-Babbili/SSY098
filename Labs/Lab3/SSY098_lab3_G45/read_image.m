function img = read_image(file_path)

image = imread(file_path);

img = im2double(image);

imagesc(img);
end