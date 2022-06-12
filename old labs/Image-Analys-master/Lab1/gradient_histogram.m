function histogram = gradient_histogram(grad_x, grad_y)


angel = atan2(grad_y, grad_x);

a1 = find( 0 < angel & angel <= pi/4);
b1 = find((pi/4) < angel & angel <= 2*(pi/4));
c1 = find(2*(pi/4) < angel & angel <= 3*(pi/4));
d1 = find(3*(pi/4) < angel & angel <= pi);

a2 = find( -pi/4 <= angel & angel < 0);
b2 = find( -(pi/4)*2 <= angel & angel < -pi/4);
c2 = find( -(pi/4)*3 <= angel & angel < -(pi/4)*2);
d2 = find( -(pi/4)*4 <= angel & angel < -(pi/4)*3);

magnitud = zeros(8,1);
for i=1:length(a1)
    q1 = a1(i);
  magnitud(1) = magnitud(1) + sqrt(((grad_y(q1))^2)+((grad_x(q1))^2));
end

for i=1:length(b1)
    q2 = b1(i);
  magnitud(2) = magnitud(2) + sqrt(((grad_y(q2))^2)+((grad_x(q2))^2));
end

for i=1:length(c1)
    q3 = c1(i);
  magnitud(3) = magnitud(3) + sqrt(((grad_y(q3))^2)+((grad_x(q3))^2));
end

for i=1:length(d1)
    q4 = d1(i);
  magnitud(4) = magnitud(4) + sqrt(((grad_y(q4))^2)+((grad_x(q4))^2));
end

for i=1:length(a2)
    q5 = a2(i);
  magnitud(5) = magnitud(5) + sqrt(((grad_y(q5))^2)+((grad_x(q5))^2));
end

for i=1:length(b2)
    q6 = b2(i);
  magnitud(6) = magnitud(6) + sqrt(((grad_y(q6))^2)+((grad_x(q6))^2));
end

for i=1:length(c2)
    q7 = c2(i);
  magnitud(7) = magnitud(7) + sqrt(((grad_y(q7))^2)+((grad_x(q7))^2));
end

for i=1:length(d2)
    q8 = d2(i);
  magnitud(8) = magnitud(8) + sqrt(((grad_y(q8))^2)+((grad_x(q8))^2));
end

histogram = magnitud;