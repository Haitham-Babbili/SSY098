function [A,t]=estimate_affine(pts,pts_tilde)

% Solves the following equation
%  (x y 0 0 1 0)\  ( x' )
%  (0 0 x y 0 1) \ ( y' )
% where (x,y) are the initial point and (x',y') is the transformed point
K=3;
B=zeros(2,2*K,K);
f=zeros(2*K);
C=zeros(2*K);

B=[pts(1,1) pts(2,1) 0 0 1 0;
 0 0 pts(1,1) pts(2,1) 0 1;
 pts(1,2) pts(2,2) 0 0 1 0;
 0 0 pts(1,2) pts(2,2) 0 1;
 pts(1,3) pts(2,3) 0 0 1 0;
 0 0 pts(1,3) pts(2,3) 0 1];
f=[pts_tilde(1,1);
    pts_tilde(2,1);
    pts_tilde(1,2);
    pts_tilde(2,2);
    pts_tilde(1,3);
    pts_tilde(2,3)];
C=B\f;

A=[C(1) C(2);
   C(3) C(4)];
t=[C(5);
   C(6)];

end