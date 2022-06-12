%% Bonus Assignment 3
% By Qixun Qu
% 2017/02/26
% Bonus Assignment 3 of
% Statistic Inference

%% Clean Environment
clc
clear
close all

%% Load Data
load ears.mat

%% Preparation
% Get differences between two samples
diff = ears(:,2) - ears(:,1);

% Get abstract value of diff
abs = abs(diff);

% Get the sign of diff
sgn = sign(diff);

% Get the rank of diff's elements
% the same number will get same rank
[~, rnk] = ismember(abs, sort(abs));
% Elements in zero are not taken into consideration
rnk = rnk - length(find(diff == 0));

% Process the rank, for example
% Before: 1,   1,   1,   1,   5,  6,   6
% After:  2.5, 2.5, 2.5, 2.5, 5,  6.5, 6.5
rnk_q = unique(rnk);
for i = 1 : length(rnk_q)

    idx = find(rnk == rnk_q(i));
    len = length(idx);
    
    if len > 1
       rnk(idx) = rnk_q(i) + sum(1:len-1)/len;
    end

end

% Show a table that consists of all information
% ontained above
names = {'Brst', 'Botl', 'diff','abs', 'sign', 'rank'};
T = table(ears(:,1), ears(:,2), diff, abs, sgn, rnk, ...
          'VariableNames', names);
disp(T)

clear i idx len rnk_q names

%% Problem A
% Plot the difference with respect to breast-fed babies
% and bottle-fed babies respectively

% figure
% plot(ears(:,1), diff, 'k.', 'MarkerSize', 10), grid on
% set(gca, 'FontSize', 12)
% xlabel('Durations of Breast-Fed Infants')
% ylabel('Differences (days)')
% 
% figure
% plot(ears(:,2), diff, 'k.', 'MarkerSize', 10), grid on
% set(gca, 'FontSize', 12)
% xlabel('Durations of Bottle-Fed Infants')
% ylabel('Differences (days)')

%% Problem B - Part 1
% Plot the distribution of difference

% figure
% histogram(diff, 25), grid on
% set(gca, 'FontSize', 12)
% xlabel('Differences in Days')

%%  Problem B - Part 2
% Conpute test statistics
W_plus = sum(rnk(sgn == 1));

% n is the number of non-zeros differences
n = length(find(diff ~= 0));

EW_plus = n * (n+1) / 4;
VarW_plus = n * (n+1) * (2*n+1) / 24;

Z = (W_plus - EW_plus) / sqrt(VarW_plus);

% Obtain two-sided P-value
P = 2*(1 - normcdf(Z));

% Print result and some comments
fprintf(['The null hypothesis is there is no difference\n' ...
         'between breast-fed babies and bottle-fed babies\n' ...
         'in durations of the first episode of otitis-media.\n\n'])
fprintf('Two-sided P-value is: %.4f\n\n', P)
fprintf(['It is strong to reject the null hypothesis,\n' ...
         'which means that the durations in the first\n' ...
         'episode of otitis-media of both breast-fed\n' ...
         'babies and bottle-fed babies are different.\n\n'])
