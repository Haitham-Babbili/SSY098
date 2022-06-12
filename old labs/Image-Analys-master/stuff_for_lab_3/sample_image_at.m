function value = sample_image_at(img, position)

x=round(position(1));
y=round(position(2));

diment = size(img);

if  x >= 1 && x <= diment(1) && y >= 1 && y <= diment(2)

    value = img(x,y);
else
    value = 1;
end

end

