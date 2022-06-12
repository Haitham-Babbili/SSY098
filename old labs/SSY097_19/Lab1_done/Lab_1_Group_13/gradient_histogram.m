function histogram = gradient_histogram(grad_x, grad_y);
% - INPUT
%  gradient in x-directino, gradient in y-direction
% 
% - OUTPUT
%  A vector containing the histogram

% angle, atan2 takes the tan inverse of grad_y and grad_x
angel=atan2(grad_y,grad_x); 

% Retreives the indixes in "angle" where the different angles can be found
a1 = find( 0 < angel & angel <= pi/4);
b1 = find((pi/4) < angel & angel <= 2*(pi/4));
c1 = find(2*(pi/4) < angel & angel <= 3*(pi/4));
d1 = find(3*(pi/4) < angel & angel <= pi);

a2 = find( -pi/4 <= angel & angel < 0);
b2 = find( -(pi/4)*2 <= angel & angel < -pi/4);
c2 = find( -(pi/4)*3 <= angel & angel < -(pi/4)*2);
d2 = find( -(pi/4)*4 <= angel & angel < -(pi/4)*3);

histogram = zeros(8,1);

for i=1:length(a1)
    q1 = a1(i);
  histogram(1) = histogram(1) + sqrt(((grad_y(q1))^2)+((grad_x(q1))^2));
end

for i=1:length(b1)
    q2 = b1(i);
  histogram(2) = histogram(2) + sqrt(((grad_y(q2))^2)+((grad_x(q2))^2));
end

for i=1:length(c1)
    q3 = c1(i);
  histogram(3) = histogram(3) + sqrt(((grad_y(q3))^2)+((grad_x(q3))^2));
end

for i=1:length(d1)
    q4 = d1(i);
  histogram(4) = histogram(4) + sqrt(((grad_y(q4))^2)+((grad_x(q4))^2));
end

for i=1:length(a2)
    q5 = a2(i);
  histogram(5) = histogram(5) + sqrt(((grad_y(q5))^2)+((grad_x(q5))^2));
end

for i=1:length(b2)
    q6 = b2(i);
  histogram(6) = histogram(6) + sqrt(((grad_y(q6))^2)+((grad_x(q6))^2));
end

for i=1:length(c2)
    q7 = c2(i);
  histogram(7) = histogram(7) + sqrt(((grad_y(q7))^2)+((grad_x(q7))^2));
end

for i=1:length(d2)
    q8 = d2(i);
  histogram(8) = histogram(8) + sqrt(((grad_y(q8))^2)+((grad_x(q8))^2));
end

end

    