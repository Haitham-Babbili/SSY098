function mean_img = read_as_grayscale(path)
img = read_image(path);
mean_img = mean(img, 3);
end

