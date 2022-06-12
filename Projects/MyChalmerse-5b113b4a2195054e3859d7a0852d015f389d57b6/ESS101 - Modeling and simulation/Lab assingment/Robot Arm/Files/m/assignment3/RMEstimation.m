function [ goodEst, fitEst, rstEst ] = ...
    RMEstimation( est_MTD, est_WD, est_VD, S )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
%%
if strcmp(est_MTD, 'arx') || ...
   strcmp(est_MTD, 'oe')
    ra = randi(10, S, 3);
elseif strcmp(est_MTD, 'armax')
    ra = randi(10, S, 4);
elseif strcmp(est_MTD, 'bj')
    ra = randi(10, S, 5);
else
    return;
end

% Find a Good Combination
goodEst = [];
fitEst = 0;
step = 0;
h = waitbar(0, 'Please wait...', 'Name', est_MTD);
for i = 1 : S
    tmp = ra(i, :);
    eval(['est = ' est_MTD '(est_WD, tmp);']);
    [rst_tmp, fit_tmp, ~] = compare(est_VD, est);
    if fit_tmp > fitEst
        goodEst = tmp;
        fitEst = fit_tmp;
        rstEst = rst_tmp;
    end
    step = step + 1;
    waitbar((step+1)/S);
end
close(h)
end

