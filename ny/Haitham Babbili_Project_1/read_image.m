function img = read_image(path)
raw_image = imread(path);
img = im2double(raw_image);
end

