function jacobian = compute_jacobian(Ps, U)

% Function file computes the Jacobian given a 3x1-vector U 
% and a cell array of camera matrices.

N=length(Ps);

jacobian=zeros(2*N,3);

U=[U;1];

for i=1:N
    
    Picture=Ps{i};
    x=Picture(1,:)*U; 
    y=Picture(2,:)*U;
    z=Picture(3,:)*U;
    for j=1:3
        jacobian(2*i-1,j)=(Picture(1,j)*z-Picture(3,j)*x)/z^2;
        jacobian(2*i,j)=  (Picture(2,j)*z-Picture(3,j)*y)/z^2;
    end
    
end

end

