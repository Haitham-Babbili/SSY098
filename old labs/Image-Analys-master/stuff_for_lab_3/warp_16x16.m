function warped = warp_16x16(source)


diment = size(source);
warped = zeros(diment(1), diment(2));

for i=1:diment(1)
for j=1:diment(2)

    pos = [i, j];
   target = transform_coordinates(pos);
    
warped(i, j) = sample_image_at(source, [target(2), target(1)]);



end
end

end