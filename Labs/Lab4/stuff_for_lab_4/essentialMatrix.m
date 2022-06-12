function E=essentialMatrix(P1,P2)
% E=t_x*R
% t_x translation from P1 to P2 as cross product
% R rotation between P1 and P2

% extract rotation and translation from the matrices
R1=P1(1:3,1:3);
R2=P2(1:3,1:3);
t1=P1(1:3,4);
t2=P2(1:3,4);

% transform so one is right side up and not translated
t=-R2*R1'*t1-t2;
R=R2*R1';

% cross product form of translation
tx=[0 -t(3) t(2);
    t(3) 0 -t(1);
    -t(2) t(1) 0];

E=tx*R;
end

