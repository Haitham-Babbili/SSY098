function rmag13ResPlot( RMRes, RMt, RMName )
%RMResPlot Abstract of the fnunction
%   This function is created to plot response of
%   Robot Arm after being stimulated by a step impulse.
%   ---------------------------------------------------
%   Figures    |    theta1    &    alpha
%   ---------------------------------------------------
%   Arguments  |    Meaning           |   Default Value
%   ---------------------------------------------------
%   RMRes      |    Step Response     |   --
%   RMt        |    Sampling Time     |   0:0.001:10
%   RMName     |    Title of Figure   |   ''
%   ---------------------------------------------------
%   Usage samples
%   ---------------------------------------------------
%   *** Just Input Step Response--|
%   [~, RMRes] = RMStateSpace();  |
%   RMResPlot(RMRes);             |
%   *** Two Inputs                |
%   [~, RMRes] = RMStateSpace();--|- RMRes is necessary
%   t = 0:0.001:20;               |  in each situation.
%   RMResPlot(RMRes, t);          |
%   *** Three Inputs            --|
%   [~, RMRes] = RMStateSpace();
%   t = 0:0.001:20;
%   RMName = '';
%   RMResPlot(RMRes, t, RMName);
%   ---------------------------------------------------
%   2016/10/13 22:00

%% Set Default Values
if (nargin < 3) 
    RMName = '';       end
if (nargin < 2)
    RMt = 0:0.001:10;  end

%% Plot Figures
figure
set(gcf, 'Position', get(0, 'Screensize'));
% Plot theta1
subplot(3, 1, 1)
plot(RMt, RMRes(:, 1), 'k', 'LineWidth', 1); grid on
axis([0 10 0 1200])
set(gca, 'FontSize', 16, 'YTick', (300:300:2100))
xlabel('Time', 'FontSize', 20)
ylabel('Theta1', 'FontSize', 20)
title(RMName, 'FontSize', 24)
% Plot dtheta1
subplot(3, 1, 2)
plot(RMt, RMRes(:, 2), 'k', 'LineWidth', 1); grid on
axis([0 10 0 2.5])
set(gca, 'FontSize', 16, 'YTick', [0 1 2 2.5])
xlabel('Time', 'FontSize', 20)
ylabel('dTheta1', 'FontSize', 20)
% Plot alpha
subplot(3, 1, 3)
plot(RMt, RMRes(:, 3), 'k', 'LineWidth', 1); grid on
axis([0 10 -4.5 4.5])
set(gca, 'FontSize', 16, 'YTick', [-4.5 -2.5 0 2.5 4.5])
xlabel('Time', 'FontSize', 20)
ylabel('Alpha', 'FontSize', 20)

end

