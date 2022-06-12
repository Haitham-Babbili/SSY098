function errors = reprojection_errors(Ps, us, U)

N = length(Ps); % get the size of all cameras 

% Make a vector to store the error value in it
% errors should be a vector contains  N errors (Euclidean distance)
% between known images points and re-projected image points
errors=zeros(N,1);

positive = check_depths(Ps, U);

U=[U;1];

for i=1:length(Ps)
    if positive(i)== 0
        errors(i)= Inf;
    else
        % Get the re-projected points coordinates
        x = (Ps{i}(1,:)*U) / (Ps{i}(3,:)*U);
        y = (Ps{i}(2,:)*U) / (Ps{i}(3,:)*U);
        
       %Get the right the Euclidean distance
        errors(i) = sqrt(sum(([x; y] - us(:, i)).^2));
    end
end
end

