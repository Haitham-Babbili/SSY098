function U=minimal_triangulation(Ps,us)
%
% Solves  (a_1 a_2 a_3 -x_1     0 )\    (-a_4  )
%         (b_1 b_2 b_3 -x_2     0 ) \   (-b_4  )
%         (c_1 c_2 c_3 -1       0 )  \  (-c_4  )
%         (a'_1 a'_2 a'_3 0 -x'_1 )   \ (-a'_4 )
%         (b'_1 b'_2 b'_3 0 -x'_2 )    \(-b'_4 )
%
% where a_i is the first row b_i second and c_i third in P1
% and a'_i, b'_i is the first and secon row of P2 respectively
%
%
% extract matrices
P1=Ps{1};
P2=Ps{2};
% construct matrix
M=[P1(1,1:3) -us(1,1) 0;
   P1(2,1:3) -us(2,1) 0;
   P1(3,1:3) -1       0;
   P2(1,1:3) 0     -us(1,2); 
   P2(2,1:3) 0     -us(2,2) ];
% construct RHS
b=[-P1(1,4);
   -P1(2,4);
   -P1(3,4);
   -P2(1,4);
   -P2(2,4)];
x=M\b;
U=x(1:3);
end