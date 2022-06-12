clc;
clear;
close all;

%% Calculate transform function
N = 64;
Km = 0.00839;
Rm = 3.21;
J = 0.0017;

% A = [0 1; 0 -(N*N)*(Km*Km)/(J*Rm)];
% B = [0; (N*Km)/(J*Rm)];
A = [0 1; 0 -0.898/J];
B = [0; 0.1673/J];
C = [1 0; 0 1];
D = zeros(1,1);

G = ss(A, B, C, D);
tf(G)

%% Show step response
% t = 0:0.1:20;
% step(G, t)