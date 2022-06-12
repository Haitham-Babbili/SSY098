function histogram = gradient_histogram(grad_x, grad_y)


angle=atan2(grad_y,grad_x); 

% calculat the qudriant for evry angle
angle1 = find( 0 < angle & angle <= pi/4);
angle2 = find((pi/4) < angle & angle <= pi/2);
angle3 = find(pi/2 < angle & angle <= 3*(pi/4));
angle4 = find(3*(pi/4) < angle & angle <= pi);
angle5 = find( -pi/4 <= angle & angle < 0);
angle6 = find( -pi/2 <= angle & angle < -pi/4);
angle7 = find( -(pi/4)*3 <= angle & angle < -pi/2);
angle8 = find( -(pi/4)*4 <= angle & angle < -(pi/4)*3);

histogram = zeros(8,1);


for i=1:length(angle1)
    quad_1 = angle1(i);
  histogram(1) = histogram(1) + sqrt(((grad_y(quad_1)).^2)+((grad_x(quad_1)).^2));
end

for i=1:length(angle2)
    quad_2 = angle2(i);
  histogram(2) = histogram(2) + sqrt(((grad_y(quad_2)).^2)+((grad_x(quad_2)).^2));
end

for i=1:length(angle3)
    quad_3 = angle3(i);
  histogram(3) = histogram(3) + sqrt(((grad_y(quad_3)).^2)+((grad_x(quad_3)).^2));
end

for i=1:length(angle4)
    quad_4 = angle4(i);
  histogram(4) = histogram(4) + sqrt(((grad_y(quad_4)).^2)+((grad_x(quad_4)).^2));
end

for i=1:length(angle5)
    quad_5 = angle5(i);
  histogram(5) = histogram(5) + sqrt(((grad_y(quad_5)).^2)+((grad_x(quad_5)).^2));
end

for i=1:length(angle6)
    quad_6 = angle6(i);
  histogram(6) = histogram(6) + sqrt(((grad_y(quad_6)).^2)+((grad_x(quad_6)).^2));
end

for i=1:length(angle7)
    quad_7 = angle7(i);
  histogram(7) = histogram(7) + sqrt(((grad_y(quad_7)).^2)+((grad_x(quad_7)).^2));
end

for i=1:length(angle8)
    quad_8 = angle8(i);
  histogram(8) = histogram(8) + sqrt(((grad_y(quad_8)).^2)+((grad_x(quad_8)).^2));
end
end

