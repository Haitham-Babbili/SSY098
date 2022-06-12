function warped = warp_16x16(source)

% Input information:
% source: This is the original image given
%   Output:
%  The warped image

[x_axis, y_axis]=size(source);
warped= zeros(x_axis, y_axis);

for i=1:x_axis
    for k= 1:y_axis
        position = transform_coordinates([i,k]);

        value=sample_image_at(source,[position(2) position(1)]);
        
        warped(i,k)=value; % put the value in warped image
    end
end

end

