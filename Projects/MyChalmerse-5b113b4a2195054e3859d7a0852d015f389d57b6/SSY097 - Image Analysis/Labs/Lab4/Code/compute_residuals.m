function all_residuals = compute_residuals( Ps, us, U )
%COMPUTE_RESIDUALS Compute residuals vector between reprojected points and
%known image points.
%   Input arguments:
%   - Ps : a cell contains n 3x4 camera matrix,
%     the ith matrix can be presented as
%        |<-- ai -->|   | ai1 ai2 ai3 ai4 |
%   Pi = |<-- bi -->| = | bi1 bi2 bi3 bi4 |
%        |<-- ci -->|   | ci1 ci2 ci3 ci4 |
%   - us : a 2xn matrix contains n known image points,
%   the ith point is [xi; yi]
%   - U : a triangulated 3D point
%   Output:
%   - all_residulas : a vector in length of 2n, containing the residuals
%   for each point in x and y respectively
%   ri[U] = | (ai*U) / (ci*U) | - | xi |
%           | (bi*U) / (ci*U) |   | yi |
% Author: Qixun Qu

% Obtain the number of camera matrix
pts_num = length(Ps);

% Initialize the matrix to store residuals
all_residuals = zeros(2, pts_num);

% Add a 1 after the last row of U
U = [U; 1];

for i = 1 : pts_num

    % Compute depth first
    lambda = Ps{i}(3,:)*U;
    
    % Check the sign of depth,
    % if it is not positive, mark the ith residuals as inf
    % indicating that it is an outlier
    if lambda <= 0 || isnan(lambda)
        all_residuals(:,i) = [inf; inf];
        continue
    end
    
    % Calculate the reprojected points
    x_hat = (Ps{i}(1,:)*U) / lambda;
    y_hat = (Ps{i}(2,:)*U) / lambda;
    
    % Calculate residuals
    all_residuals(:,i) = [x_hat; y_hat] - us(:,i);

end

% Convert matrix to a vector
all_residuals = all_residuals(:);

end