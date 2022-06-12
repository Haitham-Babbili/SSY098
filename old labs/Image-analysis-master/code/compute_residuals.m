function all_residuals=compute_residuals(Ps,us,U)
% takes N cameras and N 2D points and a 3D point.
% computes a 2N x 1 vector with reprojection residuals 

N=size(Ps,2);
all_residuals=zeros(2,N);

U=[U;1];

for i=1:N
    depth=Ps{i}(3,:)*U;
    
    if depth<=0 || isnan(depth)
        all_residuals(:,i)=[inf;inf];
        continue        
    end
    
    x= (Ps{i}(1,:)*U)/depth;
    y= (Ps{i}(2,:)*U)/depth;

    all_residuals(:,i)=[x;y]-us(:,i);
end
    all_residuals=all_residuals(:);
end