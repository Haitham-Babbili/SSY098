function RMGBCmpPlot( est_ALL, greyMdls, Ns )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明

fit_best = 0;
num_best = 0;
for i = 1 : Ns
    [~, fit_tmp, ~] = compare(est_ALL{i}, greyMdls{i});
    if abs(fit_tmp) > fit_best
        fit_best = abs(fit_tmp);
        num_best = i;
    end
end
compare(est_ALL{num_best}, greyMdls{num_best});
%legend(gca, 'off');
title('Simulation Response Comparison', 'FontSize', 20);
set(gca, 'FontSize', 16);
xlabel('Time', 'FontSize', 20);
ylabel('dTheta1', 'FontSize', 20);

end

