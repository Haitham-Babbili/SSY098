function p = sigmoid( y )
%SIGMOID Compute sigmoid of y.
%   Input argument:
%   - y : a number or a matrix
%   Output:
%   - p : sigmoid of y
%             1
%   p = --------------
%         1 + e^(-y)
% Author: Qixun Qu

p = 1 ./ (1 + exp(-y));

end

