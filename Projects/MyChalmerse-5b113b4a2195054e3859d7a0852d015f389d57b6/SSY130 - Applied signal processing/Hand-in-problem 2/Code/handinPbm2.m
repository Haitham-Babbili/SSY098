%% Clean Environment
clc;
clear;
close all;

%% Load Data
load 'hip2.mat'
N = length(signal);
% Plot Data
figure (1)
plot(1:length(observation), observation,...
     1:length(signal), signal, 'LineWidth', 1);grid on
set(gca, 'FontSize', 14)
legend('Observed Signal', 'Original Signal', 'Location', 'northwest',...
       'Orientation', 'horizontal')
xlabel('Time (s)')
ylabel('Distance (km)')

%% Calculate Derivative
ds = diff(signal);
do = diff(observation);
% Plot Data
figure (2)
plot(1:length(do), do*1000, 'LineWidth', 1);grid on
hold on
plot(1:length(ds), ds*1000, 'LineWidth', 1.5)
set(gca, 'FontSize', 14)
legend('Observed Signal', 'Original Signal', 'Location', 'northwest',...
       'Orientation', 'horizontal')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
hold off

%% Filter Construction
weight = 1;
h1 = firpm(10, [0 0.1], [0 1]*pi*weight, 'differentiator');
h2 = firpm(50, [0 0.1 0.2 1], [1 1 0 0]);
h = conv(h1, h2);
% Plot Data
figure (3)
stem(1:length(h), h, 'filled', 'MarkerSize', 4);grid on
set(gca, 'FontSize', 12)
xlabel('N', 'FontSize', 14)
ylabel('Coefficient', 'FontSize', 14)
% Plot Frequency and Phase Response
[hf, wf] = freqz(h);
figure (4)
subplot(2, 1, 1)
plot(wf/pi, 20*log10(abs(hf)), 'LineWidth', 1);grid on
set(gca, 'FontSize', 12)
axis([-inf inf -80 20])
xlabel('Normalized Frequency (¡Á\pi rad/sample)')
ylabel('Magnitude (dB)')
subplot(2, 1, 2)
plot(wf/pi, unwrap(angle(hf)), 'LineWidth', 1);grid on
set(gca, 'FontSize', 12)
axis([-inf inf -30 5])
xlabel('Normalized Frequency (¡Á\pi rad/sample)')
ylabel('Phase (rads)')

%% Removing Delay
yo = conv(h, observation);
% Plot Data
figure (5)
plot(1:length(yo), yo*1000, 1:length(ds), ds*1000, 'LineWidth', 1);grid on
set(gca, 'FontSize', 14)
axis([-inf inf -50 750])
legend('Filtered Observed Signal', 'Original Signal',...
       'Location', 'northwest')
xlabel('Time (s)')
ylabel('Velocity (m/s)')

% N is the length of filter
% Delay = (N - 1) / 2
delay = (length(h) - 1) / 2;
yrd = yo(delay+1 : delay+N);
% Plot Data
figure (6)
plot(1:length(yrd), yrd*1000, 1:length(ds), ds*1000, 'LineWidth', 1);grid on
set(gca, 'FontSize', 14)
axis([-inf inf -50 750])
legend('Filtered Observed Signal', 'Original Signal',...
       'Location', 'northwest')
xlabel('Time (s)')
ylabel('Velocity (m/s)')

%% Modifying Gain
ysh1 = conv(signal, h1);
ysh = conv(signal, h);
yshrd = ysh(delay+1 : delay+N);
% Plot Data
figure (7)
plot(1:length(ysh1), ysh1*1000,...
     1:length(yshrd), yshrd*1000, 1:length(ds), ds*1000, 'LineWidth', 1.5)
grid on
set(gca, 'FontSize', 14)
axis([-inf inf -100 800])
legend('Diff Filter',...
       'Designed Filter', 'Original Signal',...
       'Location', 'northwest')
xlabel('Time (s)')
ylabel('Velocity (m/s)')

% Modify Filter
weight = max(ds(200:400)) / max(ysh1(200:400));
h1m = firpm(10, [0 0.1], [0 1]*pi*weight, 'differentiator');
hm = conv(h1m, h2);
yom = conv(hm, observation);
yomrd = yom(delay+1 : delay+N);
% Plot Data
figure (8)
plot(1:length(yomrd), yomrd*1000, 1:length(ds), ds*1000, 'LineWidth', 1)
grid on
set(gca, 'FontSize', 14)
axis([-inf inf -2 75])
legend('Filtered Observed Signal', 'Original Signal',...
       'Location', 'northwest')
xlabel('Time (s)')
ylabel('Velocity (m/s)')

%% Amplitude and Phase Response
[hfm, wfm] = freqz(hm);
[h1f, w1f] = freqz(h1m);
% Plot Data
% Plot Amplitude
figure (9)
plot(wfm/pi, 20*log10(abs(hfm)), 'LineWidth', 1);grid on
hold on
plot(w1f/pi, 20*log10(abs(h1f)), 'LineWidth', 1);grid on
set(gca, 'FontSize', 14)
axis([-inf inf -100 40])
legend('Designed Filter', 'Diff Filter')
xlabel('Normalized Frequency (¡Á\pi rad/sample)')
ylabel('Magnitude (dB)')
hold off
% Plot Phase
figure (10)
plot(wfm/pi, unwrap(angle(hfm)), 'LineWidth', 1);grid on
hold on
plot(w1f/pi, unwrap(angle(h1f)), 'LineWidth', 1);grid on
set(gca, 'FontSize', 14)
% axis([-inf inf -inf inf])
legend('Designed Filter', 'Diff Filter')
xlabel('Normalized Frequency (¡Á\pi rad/sample)')
ylabel('Phase (rads)')
hold off

%% Signal & Noised Signal
dshm = conv(hm, signal);
dshmrd = dshm(delay+1 : delay+N);
dohm = conv(hm, observation);
dohmrd = dohm(delay+1 : delay+N);
dsh1m = conv(h1m, signal);
doh1m = conv(h1m, observation);
% Plot Data
figure (11)
plot(1:length(dsh1m), dsh1m*1000, ...
     1:length(dshmrd), dshmrd*1000,...
     1:length(dohmrd), dohmrd*1000,...
     'LineWidth', 1);grid on
set(gca, 'FontSize', 14)
axis([-inf inf -2 60])
legend('Original Signal - Diff Filter',...
       'Original Signal - Designed Filter',...
       'Observed Signal - Designed Filter',...
       'Location', 'south')
xlabel('Time (s)')
ylabel('Velocity (m/s)')

figure(12)
plot(1:length(doh1m), doh1m*1000, 'LineWidth', 1);grid on
hold on
plot(1:length(dohmrd), dohmrd*1000, 'LineWidth', 1.5)
set(gca, 'FontSize', 14)
axis([-inf inf -1000 1000])
legend('Observed Signal - Diff Filter',...
       'Observed Signal - Designed Filter',...
       'Location', 'south')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
hold off
