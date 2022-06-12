function warped=warp_16x16(source)
warped=zeros(16,16);
for i=1:16
    for j=1:16
        % transform to new coordinate
        pos=transform_coordinates([i,j]);
        %sample image at that coordinate
        value=sample_image_at(source,[pos(2) pos(1)]);
        % set value in warped image
        warped(i,j)=value;
    end
end
end