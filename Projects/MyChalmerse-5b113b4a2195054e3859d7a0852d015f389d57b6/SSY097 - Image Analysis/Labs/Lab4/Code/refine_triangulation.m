function U = refine_triangulation( Ps, us, Uhat )
%REFINE_TRIANGULATION Refine the triangulated points by the method of
%Gauss-Newton with five iterations.
%   Input arguments:
%   - Ps : a cell contains n 3x4 camera matrix
%   - us : a 2xn matrix contains n known image points
%   - Uhat : the triangulated points generated in previous step, which need
%   to be refined
%   Output:
%   - U : the refind triangulated points as the equation
%   U(k+1) = U(k) - (J' * J)^-1 * J' * r_bar,
%   where J is the Jacobian matrix, r_bar is the resifuals vector
% Author: Qixun Qu

% Set the number of iteration
iter_num = 5;

% Initialize the refind points as
% the estimated points in last step
U = Uhat;

for i = 1 : iter_num
    
    % Calculate the residuals vector
    r_bar = compute_residuals(Ps, us, U);
    % Calculate the Jacobian matrix
    J = compute_jacobian(Ps, U);
    % Update the triangulated points
    U = U - (J'*J)\J'*r_bar;

end

end