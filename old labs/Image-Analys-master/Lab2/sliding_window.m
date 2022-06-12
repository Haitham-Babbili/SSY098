function probmap = sliding_window(img, w, w0)

filterdimg = imfilter(img, w, 'symmetric');

y = sum(filterdimg,3)+w0;

probmap = 1./(1+exp(-y));