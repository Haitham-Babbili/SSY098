function errors = reprojection_errors( Ps, us, U )
%REPROJECTION_ERRORS Calculate the errors between known image points and
%reprojected points.
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
%   - errors : a vector contains n errors (Euclidean distance)
%   between known images points and reprojected points as follows:
%   xi_hat = (ai*U) / (ci*U), yi_hat = (bi*U) / (ci*U)
%   errors(i) = sqrt((xi_hat - xi)^2 + (yi_hat - yi)^2)

% Get the number of camera matrix
pts_num = length(Ps);

% Initialize the errors vector
errors = zeros(pts_num, 1);

% Check the depth for each camera matrix
positive = check_depths(Ps, U);

% Add a 1 after the last row of U
U = [U; 1];

for i = 1 : pts_num

    if positive(i) == 0
        % If the ith depth is not positive, the error is inf,
        % in other words, it would be marked as an outlier
        errors(i) = inf;
    else
        % Calculte the reprojected points
        x_hat = (Ps{i}(1,:)*U) / (Ps{i}(3,:)*U);
        y_hat = (Ps{i}(2,:)*U) / (Ps{i}(3,:)*U);
        % Calculate the Euclidean distance
        errors(i) = sqrt(sum(([x_hat; y_hat] - us(:, i)).^2));
    end

end

end