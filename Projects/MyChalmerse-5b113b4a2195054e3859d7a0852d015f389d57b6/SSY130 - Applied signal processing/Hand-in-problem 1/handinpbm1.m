%% 
clc;
clear;
close all;

%%
w0 = 16*pi;
w = -40*pi:0.1*pi:40*pi;
% H(w)
Hw = (1 + 1j*w/w0).^-1;
% Xs(w)
Xsw = zeros(1, length(w));
Xsw(1, 281:520) = 1;
wt = [w;w(2:end),w(end)+pi];
wX = wt(:);
Xswp = [Xsw;Xsw];
Xswp = Xswp(:);
% N(w)
Nw = zeros(1, length(w));
Nw(1, 561:720) = 0.1;
Nw(1, 81:240) = 0.1;
wN = wt(:);
Nwp = [Nw;Nw];
Nwp = Nwp(:);
%
FXsw = Hw.* Xsw;
FXswp = [FXsw;FXsw];
FXswp = FXswp(:);
FNw = Hw .* Nw;
FNwp = [FNw;FNw];
FNwp = FNwp(:);
%
tgtV = 0.05;
FNwL = abs(abs(FNw)-tgtV);
FNwLP = find(FNwL == min(FNwL));
FNwLPDotsX = [w(FNwLP(1)) w(FNwLP(1)) w(FNwLP(2)) w(FNwLP(2))];
FNwLPDotsY = [0 tgtV tgtV 0];
% NNw
NNw = zeros(1, length(w));
NNw(1, 164:323) = FNw(1, 561:720);
NNw(1, 478:637) = FNw(1, 81:240);
wNN = wt(:);
NNwp = [NNw;NNw];
NNwp = NNwp(:);
NNwL = abs(abs(NNw)-tgtV);
NNwLP = find(NNwL == min(NNwL));
NNwLPDotsX = [w(NNwLP(1)) w(NNwLP(1)) w(NNwLP(2)) w(NNwLP(2))];
NNwLPDotsY = [0 tgtV tgtV 0];

%% Plot
%
figure (1)
set(gcf, 'Position', [50 150 1200 350]);
plot(w, abs(Hw), 'LineWidth', 2); grid on
hold on
plot(wX, Xswp, 'LineWidth', 2)
plot(wN, Nwp, 'LineWidth', 2)
axis([-40*pi 40*pi 0 1.1])
xticks([-40*pi -32*pi -16*pi -12*pi 0 12*pi 16*pi 32*pi 40*pi])
xticklabels(...
    {'-40\pi','-32\pi','-16\pi','-12\pi','0','12\pi','16\pi','32\pi','40\pi'})
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(ax, 'FontSize', 14)
legend({'|H(\omega)|', '|Xs(\omega)|', '|N(\omega)|'}, 'FontSize', 14)
xlabel('Frequency (¡Á10^3 rad/s)', 'FontSize', 18)
hold off
%
figure (2)
set(gcf, 'Position', [50 150 1200 350]);
plot(wX, abs(FXswp), 'LineWidth', 2); grid on
hold on
plot(wN, abs(FNwp), 'LineWidth', 2)
plot(FNwLPDotsX, FNwLPDotsY, ':k', 'LineWidth', 2)
plot(w(FNwLP(1)), tgtV, 'ko', 'LineWidth',2, 'MarkerSize',8)
plot(w(FNwLP(2)), tgtV, 'ko', 'LineWidth',2, 'MarkerSize',8)
text(w(FNwLP(1))-5*pi, tgtV+0.1, '(-27.7\pi, 0.05)', 'FontSize', 14)
text(w(FNwLP(2))-5*pi, tgtV+0.1, '(27.7\pi, 0.05)', 'FontSize', 14)
axis([-40*pi 40*pi 0 1.1])
xticks([-40*pi -32*pi -16*pi -12*pi 0 12*pi 16*pi 32*pi 40*pi])
xticklabels(...
    {'-40\pi','-32\pi','-16\pi','-12\pi','0','12\pi','16\pi','32\pi','40\pi'})
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(ax, 'FontSize', 14)
legend({'|H(\omega)Xs(\omega)|', '|H(\omega)N(\omega)|'}, 'FontSize', 14)
xlabel('Frequency (¡Á10^3 rad/s)', 'FontSize', 18)
hold off
%
figure (3)
set(gcf, 'Position', [50 150 1200 350]);
plot(wX, abs(FXswp), 'LineWidth', 2); grid on
hold on
plot(wN, abs(NNwp), 'LineWidth', 2)
plot(NNwLPDotsX, NNwLPDotsY, ':k', 'LineWidth', 2)
plot(w(NNwLP(1)), tgtV, 'ko', 'LineWidth',2, 'MarkerSize',8)
plot(w(NNwLP(2)), tgtV, 'ko', 'LineWidth',2, 'MarkerSize',8)
text(w(NNwLP(1))-5*pi, tgtV+0.1, '(-12\pi, 0.05)', 'FontSize', 14)
text(w(NNwLP(2))-5*pi, tgtV+0.1, '(12\pi, 0.05)', 'FontSize', 14)
axis([-40*pi 40*pi 0 1.1])
xticks([-40*pi -32*pi -16*pi -12*pi 0 12*pi 16*pi 32*pi 40*pi])
xticklabels(...
    {'-40\pi','-32\pi','-16\pi','-12\pi','0','12\pi','16\pi','32\pi','40\pi'})
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(ax, 'FontSize', 14)
legend({'|H(\omega)Xs(\omega)|', '|H(\omega)N(\omega¡À\omega_s)|'}, 'FontSize', 14)
xlabel('Frequency (¡Á10^3 rad/s)', 'FontSize', 18)
hold off