function U = refine_triangulation(Ps, us, Uhat)

index_iterations = 5;

% Make U to be Uhat initially
U = Uhat;

for i = 1 : index_iterations
    
    all_residuals = compute_residuals(Ps, us, U); % residuals vector 
    
    jacobian = compute_jacobian(Ps, U); % Jacobian matrix
    
    U = U - (jacobian'*jacobian)\jacobian'*all_residuals; % update triangulated points

end

end

