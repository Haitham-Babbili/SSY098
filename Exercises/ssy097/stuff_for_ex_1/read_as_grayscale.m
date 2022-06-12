function img = read_as_grayscale(path_to_file)
img = read_imag(path_to_file)
img = mean(img, 3)
imagesc(img)
end
