function switch_plot(target, warped, nbr_of_times)

if nargin < 3
    nbr_of_times = 10;
end

figure(gcf)
clf
imagesc(target)
axis image
axis off
for kk = 1:nbr_of_times
    plotOne(target, 'Target Image') 
    plotOne(warped, 'Warped Image')
end
end

function plotOne(img, title_msg)

imagesc(img);
axis image
axis off
if size(img,3) == 1
    colormap gray
else
    colormap default
end
title(title_msg)
pause;
end