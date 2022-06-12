function [A, t] = estimate_affine(pts, pts_tilde)


% Get the number of coordinates points
% coord_points = size(pts, 2);

% B has 6 columns, because we have 6 unknown parameters
%B = zeros(2*numofcoord, 6);
B = [pts(1,1), pts(2,1), 1, 0, 0, 0;
         0, 0, 0, pts(1,1), pts(2,1), 1;
         pts(1,2), pts(2,2), 1, 0, 0, 0;
         0, 0, 0, pts(1,2), pts(2,2), 1
         pts(1,3), pts(2,3), 1, 0, 0, 0;
         0, 0, 0, pts(1,3), pts(2,3), 1];

Y = pts_tilde(:);

% warning('array bounds is wrong') % This is to try and remove wrong matrix bounds

D = B \ Y;


A = [D(1), D(2);
     D(3), D(4)];

t = D(5:6);
end

