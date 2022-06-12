function [A, t] = estimate_affine(pts, pts_tilde)

% Get the number of coordinates
numofcoord = size(pts, 2);

% M has 6 columns, because we have 6 unknown parameters
M = zeros(2*numofcoord, 6);


    
    % Form the matrix m
    M = [pts(1,1), pts(2,1), 1, 0, 0, 0;
         0, 0, 0, pts(1,1), pts(2,1), 1;
         pts(1,2), pts(2,2), 1, 0, 0, 0;
         0, 0, 0, pts(1,2), pts(2,2), 1
         pts(1,3), pts(2,3), 1, 0, 0, 0;
         0, 0, 0, pts(1,3), pts(2,3), 1];

% Form the matrix b,
% b contains all known target points
b = pts_tilde(:);


% Solve the linear equation
theta = M \ b;

% Form the affine transformation
A = [theta(1), theta(2);
     theta(4), theta(5)];

t = [theta(3); theta(6)];

end