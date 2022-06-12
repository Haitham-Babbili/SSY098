function jacobian=compute_jacobian(Ps,U)
% computes the 2N x 3 jacobian from N camera matrices and one 3D point


N=size(Ps,2);
jacobian=zeros(2*N,3);
U=[U;1];
for i=1:N
    camera=Ps{i};
    
    a=camera(1,:)*U;
    b=camera(2,:)*U;
    c=camera(3,:)*U;
    for j=1:3
        jacobian(2*i-1,j)=(camera(1,j)*c-camera(3,j)*a)/c^2;
        jacobian(2*i,j)=  (camera(2,j)*c-camera(3,j)*b)/c^2;
    end
    
end
end
