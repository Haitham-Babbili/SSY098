function positive = check_depths(Ps, U)
% checks the depth in each of the cameras, if it's positve that ok if not
% that will be wrong we dont save it 


N = length(Ps); % get the size of all cameras 

% mack a vector to stor the positve valve in it
positive=zeros(N,1);

U=[U;1];

% check all the cameras
for i=1:length(Ps)
  lambda=Ps{i}(3,:)*U;
    if lambda>0
        positive(i)= 1;
    else
        positive(i)= 0;
    end
end
end

