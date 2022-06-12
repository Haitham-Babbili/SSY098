function JI = jaccardIndex( CM )
% Jaccard index from CM, 2-d confusion matrix
 
CM = single(CM);
[M, N, K] = size(CM);

if K > 1
    errmsg('diceIndex: the input matrix is more than 2D');
elseif M ~= N
    errmsg('diceIndex: the input matrix is not quadratic');
elseif  M > 0
    for i = 1 : M
        JI(i) = CM(i,i) / (sum(CM(i,:)) + sum(CM(:,i)) - CM(i, i));
    end   
end

end