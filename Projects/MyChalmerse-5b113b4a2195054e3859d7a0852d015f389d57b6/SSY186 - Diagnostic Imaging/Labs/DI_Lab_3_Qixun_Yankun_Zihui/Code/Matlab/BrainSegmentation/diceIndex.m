function DI = diceIndex(CM)
% Dice index from CM, 2-d confusion matrix
 
CM = single(CM);
[M, N, K] = size(CM);

if (K>1)
    errmsg('diceIndex: the input matrix is more than 2D');
elseif (M~=N)
    errmsg('diceIndex: the input matrix is not quadratic');
elseif (M>0)
    for i=1:M
        DI(i) = 2 * CM(i,i)/(sum(CM(i,:)) + sum(CM(:,i)));
    end   
end

end