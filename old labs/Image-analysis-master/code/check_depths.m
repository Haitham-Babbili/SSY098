function positive=check_depths(Ps,U)
% checks if the depth of each camera in Ps is positive or negative
N=size(Ps,2);
positive=zeros(N,1);
X=[U;1];
% loop over all cameras
for i=1:N
  lambda=Ps{i}(3,:)*X;
    if lambda>0
        positive(i)=true;
    else
        positive(i)=false;
    end
end
end