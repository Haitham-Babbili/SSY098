clc;
clear;
close all;

J = 0.0017;

A = [0 1; 0 -0.898/J];
B = [0; 0.1673/J];
C = [0 1];
D = [0;];

G = ss(A, B, C, D);
tf(G)