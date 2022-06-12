function errors=reprojection_errors(Ps,us,U)
% computes the reprojection errors for all cameras and points 
N=size(us,2);
errors=zeros(N,1);
A=check_depths(Ps,U);
U=[U;1];
for i=1:N
    P=Ps{i};
   % for j=1:N % over all points
    if(A(i)) % if the depth is positive
          x= P(1,:)*U/(P(3,:)*U)-us(1,i);
          y= P(2,:)*U/(P(3,:)*U)-us(2,i);
          errors(i)=sqrt(x.^2+y.^2); % length of "error vector"
     else
          errors(i)=Inf;
    end
    %end
end

end