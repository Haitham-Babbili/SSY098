function [ logS0, D ] = least_square_fit( b, S )
%%LEAST_SQUARE_FIT A pseudoinverse sulution to fit a linear function. 

% M * theta = logS
% M = [1, -b(1);
%      1, -b(2);
%      :,   :  ;
%      1, -b(end)]

M = [ones(length(b), 1), -b];
theta = pinv(M) * log(S);

logS0 = theta(1);
D = theta(2);

end

