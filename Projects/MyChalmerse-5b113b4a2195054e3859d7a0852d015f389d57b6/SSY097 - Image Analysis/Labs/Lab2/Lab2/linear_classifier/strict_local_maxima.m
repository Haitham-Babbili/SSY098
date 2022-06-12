function [ max_rows, max_cols ] = strict_local_maxima( prob )
%STRICT_LOCAL_MAXIMA Find the local maxima in input matrix, the pixel of 
%the image is the probability.
%   Input argument:
%   - prob : a matrix contains probability in each point
%   Outputs:
%   - max_rows : the row number of maxima in the matrix
%   - max_cols: the column number of maxima in the matrix
% Author: Qixun Qu

% Set the size of the filter
nbh_size = 3;

% Generate a Gaussian filter to decrease the number of maxima
gs_filter = fspecial('gaussian', 3, 1);
prob_filt = imfilter(prob, gs_filter);

% Max filtering. The value of each point will be set
% as the max of its neighbourhood values.
max_filt = ordfilt2(prob_filt, 9, ones(nbh_size), 'symmetric');
% max_filts = ordfilt2(prob_filt, 8, ones(nbh_size), 'symmetric');

% Get the unchanged points between max filtering result and
% threshold filtering result.
[max_rows, max_cols] = find(prob_filt == max_filt & prob > 0.5);
% [max_rows, max_cols] = find(prob_filt > max_filts & prob > 0.5);

end