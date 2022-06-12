function jacobian = compute_jacobian( Ps, U )
%COMPUTE_JACOBIAN Compute the Jacobian matrix for residuals vector.
%   Input arguments:
%   - Ps : a cell contains n 3x4 camera matrix
%     the ith matrix can be presented as
%        |<-- ai -->|   | ai1 ai2 ai3 ai4 |
%   Pi = |<-- bi -->| = | bi1 bi2 bi3 bi4 |
%        |<-- ci -->|   | ci1 ci2 ci3 ci4 |
%   - U : a 3D point estimated or refined previously
%   Output:
%   jacobian : the partial derivatives of residuals vector,
%   its dimension is 2nx3
%
%   Generate the formula of Jacobian matrix
%
%       | dr[1,x]/dX  dr[1,x]/dY  dr[1,x]/dZ |
%       | dr[1,y]/dX  dr[1,y]/dY  dr[1,y]/dZ |
%   J = |      :           :           :     |
%       | dr[n,x]/dX  dr[n,x]/dY  dr[n,x]/dZ |
%       | dr[n,y]/dX  dr[n,y]/dY  dr[n,y]/dZ |
%
%   dr[i,x] / dX = ( ai1*ci*U - ci1*ai*U ) / ( ci*U )^2
%   dr[i,x] / dY = ( ai2*ci*U - ci2*ai*U ) / ( ci*U )^2
%   dr[i,x] / dZ = ( ai3*ci*U - ci3*ai*U ) / ( ci*U )^2
%
%   dr[i,y] / dX = ( bi1*ci*U - ci1*bi*U ) / ( ci*U )^2
%   dr[i,y] / dY = ( bi2*ci*U - ci2*bi*U ) / ( ci*U )^2
%   dr[i,y] / dZ = ( bi3*ci*U - ci3*bi*U ) / ( ci*U )^2
% Author: Qixun Qu

% Obtain the number of camera matrix
pts_num = length(Ps);

% Initialize the Jacobian matrix
jacobian = zeros(2*pts_num, 3);

% Add a 1 after the last row of points
U = [U; 1];

for i = 1 : pts_num

    Psi = Ps{i};
    aiU = Psi(1,:)*U;
    biU = Psi(2,:)*U;
    ciU = Psi(3,:)*U;
    
    for j = 1 : 3
    
        % Compute partial derivatives for residuals vector
        jacobian(2*i-1, j) = (Psi(1,j)*ciU - Psi(3,j)*aiU) / ciU^2;
        jacobian(2*i, j)   = (Psi(2,j)*ciU - Psi(3,j)*biU) / ciU^2;
    
    end

end

end