function [ dx, y ] = RMGreyBoxNL( t, x, u, N, Km, Rm, J, vargin )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

%%
y = x(2);
dx = [x(2);
      -(N*N)*(Km*Km)/(J*Rm)*x(2) + (N*Km)/(J*Rm)*u];

end

