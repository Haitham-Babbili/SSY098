function all_residuals = compute_residuals(Ps, us, U)

% Function that computes all the reprojection residuals stacked into a 
% single vector/array.

N = length(Ps);

all_residuals=zeros(2,N);

U=[U;1];

for i=1:length(Ps)
    
    depth=Ps{i}(3,:)*U;
    
    % Check the sign of depth,
    % if it is not positive, mark the ith residuals as inf
    % indicating that it is an outlier
    
    if depth<=0 || isnan(depth)
        all_residuals(:,i)=[inf;inf];
        continue        
    end
    
    x= (Ps{i}(1,:)*U)/depth;
    y= (Ps{i}(2,:)*U)/depth;

    all_residuals(:,i)=[x;y]-us(:,i); % find the residuals
end
    all_residuals=all_residuals(:); % get it as vector
end

