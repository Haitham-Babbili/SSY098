function U=refine_triangulation(Ps,us,Uhat)
sum=0;
U=Uhat;
    for i=1:5
        res=compute_residuals(Ps,us,U);
        % display residuals
       % for j=1:size(res,2)
       %    sum=sum+res(j).^2;
       % end
        %disp(sum)
        %sum=0;
        % gauss newton
        J=compute_jacobian(Ps, U);
        delta=(J'*J)\(J'*res);
        U=U-delta;%inv(J'*J)*J'*res; 
    end

end