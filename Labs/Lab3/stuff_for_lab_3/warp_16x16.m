function warped = warp_16x16(source)

[x_axi, y_axi]=size(source);
warped= zeros(x_axi, y_axi);

for i=1:x_axi
    for k= 1:y_axi
        postion = transform_coordinates([i,k]);

        value=sample_image_at(source,[postion(2) postion(1)]);
        
        warped(i,k)=value;% but the value in warped image
    end
end

end

