function U = minimal_triangulation( Ps, us )
%MINIMAL_TRIANGULATION The minimal solver to triangulate 3D points in
%global coordinate.
%   Input arguments:
%   - Ps : a cell contains two 3x4 camera matrix,
%     the ith matrix can be presented as
%        |<-- ai -->|   | ai1 ai2 ai3 ai4 |
%   Pi = |<-- bi -->| = | bi1 bi2 bi3 bi4 |
%        |<-- ci -->|   | ci1 ci2 ci3 ci4 |
%   - us : the 2x2 matrix consists of two image points, the ith point is
%   ui = [xi yi]'
%   Output:
%   - U : the estimated 3D points triangulated by two camera matrix
%   and two image points as follows:
%   Li * ui = Pi * U, where Li is the ith depth of ith camera
%   In this case, L1 * u1 = P1 * U and L2 * u2 = P2 * U
%   There are five unknown parameters, which are L1, L2, U[X, Y, Z]
%   Five equations to solve the problem
%   | a11 a12 a13 -x1 0 |       | X  |         | -a14 |
%   | b11 b12 b13 -y1 0 |       | Y  |         | -b14 |
%   | c11 c12 c13 -1  0 |   *   | Z  |    =    | -c14 |
%   | a21 a22 a23 -x2 0 |       | L1 |         | -a24 |
%   | b21 b22 b23 -y2 0 |       | L2 |         | -b24 |
%   |<--------M-------->|       |<-theta->|    |<-b->|
% Author: Qixun Qu

% Construct the matrix M
M = [Ps{1}(1,1:3), -us(1,1), 0;
     Ps{1}(2,1:3), -us(2,1), 0;
     Ps{1}(3,1:3), -1,       0;
     Ps{2}(1,1:3), 0,        -us(1,2);
     Ps{2}(2,1:3), 0,        -us(2,2)];

% Construct the matrix b
b = -[Ps{1}(:,4); Ps{2}(1:2,4)];

warning('off')

% Sove the linear equation
theta = M \ b;

% Obtain the 3D point
U = theta(1:3);

end