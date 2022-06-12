function histogram = gradient_histogram( grad_x, grad_y )
%GRADIENT_HISTOGRAM Calculate the gradient histogram for given gradients in
%x and y direction.
%   Input arguments:
%   - grad_x : x direction gradient
%   - grad_y : y direction gradient
%   Output:
%   - histogram : 8 x 1 vector consists of the sum of length in 8 gradient
%   directions
%         y          
%      \ 6|7 /                Group & Interval
%      5\ | /8          1 : [-1,  0 )   5 : [ 3,  4 )
%    ____\|/____ x      2 : [-2, -1 )   6 : [ 2,  3 )
%        /|\            3 : [-3, -2 )   7 : [ 1,  2 )
%      4/ | \1          4 : [-4, -3 )   8 : [ 0,  1 )
%      / 3|2 \       
%                    

% Calculate the direction of the sum vector
% the negative sign of grad_y: since the orientation of y axis in an image 
% is downward, the direction of grad_y in ordinary coordinate should be
% the opposite to the direction in image coordinate
% the tan^-1 of -grad_y and grad_x is devieded by (pi/4), resulting in
% eight intervals that can be presented by intergers as shown above
all_atan = atan2(-grad_y, grad_x) / (pi/4);

% Calculate the length of sum vector of each point
all_length = sqrt(grad_x.^2 + grad_y.^2);

% Initialize the vector to store histogram
hist_num = 8;
histogram = zeros(hist_num, 1);

% There are four iterations, in
% 1st : obtain group 1 & 8
% 2nd : obtain group 2 & 7
% 3rd : obtain group 3 & 6
% 4th : obtain group 4 & 5
for i = 1 : hist_num/2
    
    ngt_pos = find(all_atan >= i-1 & all_atan < i);
    histogram(hist_num-i+1) = sum(all_length(ngt_pos));
    
    pst_pos = find(all_atan >= -i & all_atan < 1-i);
    histogram(i) = sum(all_length(pst_pos));
    
end

end