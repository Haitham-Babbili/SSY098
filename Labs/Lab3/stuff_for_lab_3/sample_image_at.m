function value = sample_image_at(img, position)


new_pos=round(position);
    if new_pos(1)>size(img,1) || (new_pos(1)<1)
        value=1;
    elseif  (new_pos(2)>size(img,2)) || (new_pos(2)<1) 
        value=1;
    else
        value=img(new_pos(1),new_pos(2));
    end

end

