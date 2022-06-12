function [ A, t ] = estimate_affine( pts, pts_tilde )
% This function file is to estimate the affine transformation 
% by the given co-ordinate points
% A & t are the affine transformation parameters, 
% A is a 2x2 matrix that indicates the rotation and scaling transformation,
% t is a 2x1 vector determines
% Our Equation to be solved is denoted xy=z
% The affine transformation has 6 parameters in this our case
% Therefore, x is a Matrix of 6 columns

number_points = size(pts, 2);


x = zeros(2*number_points, 6);

for i = 1 : number_points
    
    % Form the matrix m
    x(2*i-1:2*i, :) = [pts(1,i), pts(2,i), 0, 0, 1, 0;
                       0, 0, pts(1,i), pts(2,i), 0, 1];
    
end

%x = [pts(1,1), pts(2,1), 1, 0, 0, 0;
         %0, 0, 0, pts(1,1), pts(2,1), 1;
         %pts(1,2), pts(2,2), 1, 0, 0, 0;
         %0, 0, 0, pts(1,2), pts(2,2), 1
         %pts(1,3), pts(2,3), 1, 0, 0, 0;
         %0, 0, 0, pts(1,3), pts(2,3), 1];

% z contains all the already known target points
z = pts_tilde(:);

% Solving the linear equation
y = x \ z;

% Creation of the  the affine transformation
A = [y(1), y(2);
     y(3), y(4)];

t = y(5:6);


end

