function positive = check_depths(Ps, U)
% This function checks the depth in each of the cameras. if it iss positve 
% that ok, if not that will be wrong we do not save it 


N = length(Ps); % This is to get the size of all cameras 

% Make a vector to store the positve value in it
positive=zeros(N,1);

U=[U;1];

% Check all the cameras
for i=1:length(Ps)
  lambda=Ps{i}(3,:)*U;
    if lambda>0
        positive(i)= 1;
    else
        positive(i)= 0;
    end
end
end

