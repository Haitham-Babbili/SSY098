function histogram = gradient_histogram( grad_x, grad_y )

est_angles = atan2(-grad_y, grad_x) / (pi/4);


est_length = sqrt(grad_x.^2 + grad_y.^2);

histogram = zeros(8, 1);


for j = 1 : length(histogram)/2
    
    
    negativ_angle = find(est_angles >= j-1 & est_angles < j);
    histogram(8-j+1) = sum(est_length(negativ_angle));
    
    positive_angle = find(est_angles >= -j & est_angles < 1-j);
    histogram(j) = sum(est_length(positive_angle));
    
end

end