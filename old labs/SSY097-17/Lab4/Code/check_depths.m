function positive = check_depths( Ps, U )
%CHECK_DEPTHS Check the sign for each depth, it would be 1 when depth is
%positive, otherwise it is 0.
%   Input argument:
%   - Ps : a cell contains several 3x4 camera matrix,
%     the ith matrix can be presented as
%        |<-- ai -->|   | ai1 ai2 ai3 ai4 |
%   Pi = |<-- bi -->| = | bi1 bi2 bi3 bi4 |
%        |<-- ci -->|   | ci1 ci2 ci3 ci4 |
%   - U : a 3D point
%   Output:
%   - positive : a vector indicates which depths are positive, it has the
%   same length as Ps

% Get the length of Ps
pts_num = length(Ps);

% Initilize the vector to store boolean values
positive = zeros(pts_num, 1);

% Add a 1 after the last row of U
U = [U; 1];

for i = 1 : pts_num
    
    % Compute the depth lambda as equation
    % lambda = ci * U
    lambda = Ps{i}(3,:) * U;
    
    % Check the sign of depth, if it is positive,
    % the ith value in boolean vector is 1
    if ~isnan(lambda) && lambda > 0
        positive(i) = 1;
    end

end

end