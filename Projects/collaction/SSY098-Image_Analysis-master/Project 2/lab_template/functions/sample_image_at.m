function value = sample_image_at(img, position)
    img_size = size(img);
    position = round(position);
    if(position(1) < 1|| position(2) < 1 || position(1) > img_size(2) || position(2) > img_size(1))
        value = 1;
    else
        value = img(position(1),position(2));
    end
end

