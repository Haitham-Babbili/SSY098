function value = sample_image_at(img, position)

% Output is the pixel value at the position in the input image

new_position=round(position);

    if new_position(1)>size(img,1) || (new_position(1)<1)
        value=1;
    elseif  (new_position(2)>size(img,2)) || (new_position(2)<1) 
        value=1;
    else
        value=img(new_position(1),new_position(2));
    end

end

