function allMats = RMCmpPlot( est_VD, est_MTD, Ts, svFd )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明

numPt = size(est_MTD, 2);
allMats = [];
for i = 1 : numPt
    matTmp = load([svFd est_MTD{i}]);
    allMats = cat(2, allMats, matTmp);
end

nX = (size(allMats(1).rstEst.y, 1)-1) * Ts;
xLbl = 0:Ts:nX;
colors = {'r' 'g' 'k' 'm'};
lgdTxt = '''measured''';
figure(1)
set(gcf, 'Position', get(0, 'Screensize'));
plot(xLbl, est_VD.y, 'b'); grid on; hold on
for i = 1 : numPt
    plot(xLbl, allMats(i).rstEst.y, colors{i});
    lgdTxt = [lgdTxt ', ''' est_MTD{i} '-' ...
        num2str(round(allMats(i).fitEst, 1)) '%'''];
end
title('Comparison of Measured Data with Estimated Data', ...
      'FontSize', 28);
set(gca, 'FontSize', 24);
xlabel('Time', 'FontSize', 28);
ylabel('Theta1', 'FontSize', 28);
lgdOpt = ', ''FontSize'', 15, ''Orientation'', ''horizontal''';
eval(['lgd = legend({' lgdTxt '}' lgdOpt ');']);
title(lgd, 'Estimation Results', 'FontSize', 15);
hold off

end

