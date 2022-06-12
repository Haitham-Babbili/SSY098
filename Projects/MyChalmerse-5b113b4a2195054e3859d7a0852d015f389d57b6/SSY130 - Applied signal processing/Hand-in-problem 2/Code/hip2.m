clc;
close all;

v_s=diff(signal);%real speed
v_o=diff(observation);%observe speed
figure;
plot(v_s,'*r');
hold on;
plot(v_o);
%title('True and measured signals filtered by diff');
xlabel('Time[s]');
ylabel('Speed[km/s]');
legend('True speed','Estimated speed');

%Apply Euler approximation to the true and measured signals respectively
dif=[1 -1];
[h1,w1]=freqz(dif);
figure;
subplot(211);
plot(w1/pi,abs(h1));
%title('Amplitude for diff filter');
xlabel('Normalized Frequency[\times\pi rad/sample]');
ylabel('Magnitude');
subplot(212);
plot(w1/pi,angle(h1));
%title('Angle for diff filter');
xlabel('Normalized Frequency[\times\pi rad/sample]');
ylabel('Phase[degrees]');

%design a low-pass FIR differentiator 
h1=firpm(10,[0 0.1 0.2 1],[0 1 0 0],'differentiater');
%h1=firpm(10,[0 0.1],[0 0.1*pi]);
plot(abs(h1));

h2=firpm(50,[0 0.1 0.2 1],[1 1 0 0]);
H2=fft(h2);

h=conv(h1,h2);
figure;
stem(h);%resulting filter coefficients
%title('FIR filter coefficients');
xlabel('Coefficients[N]');
ylabel('Amplitude');
[h2,w2]=freqz(h);
figure;
subplot(211);
plot(w2/pi,abs(h2));
%title('Amplitude for diff filter');
xlabel('Normalized Frequency[\times\pi rad/sample]');
ylabel('Magnitude');
subplot(212);
plot(w2/pi,angle(h2));
%title('Angle for diff filter');
xlabel('Normalized Frequency[\times\pi rad/sample]');
ylabel('Phase[degrees]');

v_s_temp1=conv(h,signal);%filter the noise-free data
num=length(v_s);
v_s_temp2=v_s_temp1(1:num);%neglect the last few fluctuate datas
delay=(length(h)-1)/2;%determine the delay=(N-1)/(2*fs),fs=1Hz
v_s_new=v_s_temp1(delay+1:num+delay);%compensate the delay
gain=max(v_s)/max(v_s_temp2);
v_s_new=gain*v_s_new;%get a correct gain

v_o_temp1=conv(h,observation);%apply filter to the measured data
v_o_new=v_o_temp1(delay+1:num+delay);%compensate the delay
v_o_new=gain*v_o_new;%get a correct gain

figure;
n=560;
plot(v_s_new(1:n),'r');
hold on;
plot(v_o_new(1:n));

%filter the noise free data and compare with the result with the diff
%filtering
figure;
plot(v_s_new(1:n),'r');
hold on;
plot(v_s(1:n));