function errors = reprojection_errors(Ps, us, U)

N = length(Ps); % get the size of all cameras 

% mack a vector to stor the errors valve in it
errors=zeros(N,1);

positive = check_depths(Ps, U);

U=[U;1];

for i=1:length(Ps)
    if positive(i)== 0
        errors= Inf;
    else
        % get the reprojected points cordenates
        x = (Ps{i}(1,:)*U) / (Ps{i}(3,:)*U);
        y = (Ps{i}(2,:)*U) / (Ps{i}(3,:)*U);
       
        errors(i) = sqrt(sum(([x; y] - us(:, i)).^2)); % get the right the distance
    end
end
end

