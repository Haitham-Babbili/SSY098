function U = minimal_triangulation(Ps, us)
% This function takes two camera matrices, Ps, and two image points, us, 
% and triangulates a 3D point. The image points are a 2 x 2 array whereas
% the camera matrices is a cell list with one camera matrix in each cell.

    P = zeros(5, 5);
    P(1, :,:) = [Ps{1}(1,1:3), -us(1,1), 0 ;];
    P(2, :,:) = [Ps{1}(2,1:3), -us(2,1), 0 ;];
    P(3, :,:) = [Ps{1}(3,1:3), -1,        0;];
    P(4, :,:) = [Ps{2}(1,1:3), 0, -us(1,2) ;];
    P(5, :,:) = [Ps{2}(2,1:3), 0, -us(2,2); ];
    
    P=[P(1, :,:);
        P(2, :,:);
        P(3, :,:);
        P(4, :,:);
        P(5, :,:)];
    
   v = -[Ps{1}(:,4); Ps{2}(1:2,4)];
 
theta = P \ v;
   
    U = theta(1:3);
end