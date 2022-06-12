function [A, t] = least_squares_affine(pts, pts_tilde)

% Get the number of coordinates
numofcoord = size(pts, 2);

% M has 6 columns, because we have 6 unknown parameters
M = zeros(2*numofcoord, 6);


    
    % Form the matrix m
    for i=1:numofcoord
    M(2*i-1:2*i, :) = [pts(1,i), pts(2,i), 1, 0, 0, 0;
         0, 0, 0, pts(1,i), pts(2,i), 1];


% b is the target points
b = pts_tilde(:);


% Solves the linear equation
theta = M \ b;

% Form the affine transformation
A = [theta(1), theta(2);
     theta(4), theta(5)];

t = [theta(3); theta(6)];

end