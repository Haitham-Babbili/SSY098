function value=sample_image_at(img,position)
position_new=round(position);
    if position_new(1)>size(img,1) || (position_new(1)<1)
        value=1;
    elseif  (position_new(2)>size(img,2)) || (position_new(2)<1) 
        value=1;
    else
        value=img(position_new(1),position_new(2));
    end
end