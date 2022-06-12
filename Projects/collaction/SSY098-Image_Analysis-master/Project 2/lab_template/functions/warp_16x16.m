function warped = warp_16x16(source)
    warped = zeros(16);
    for i = 1:16
        for j = 1:16
            pos = [i j];
            pos_tilde = transform_coordinates(pos);
            value = sample_image_at(source, [pos_tilde(2),pos_tilde(1)]);
            warped(pos(2),pos(1)) = value;
        end
    end
end

