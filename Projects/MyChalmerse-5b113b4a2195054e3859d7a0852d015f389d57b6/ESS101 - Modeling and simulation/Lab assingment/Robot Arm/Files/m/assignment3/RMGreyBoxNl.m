function [ dx, y ] = RMGreyBoxNL( t, x, u, N, Km, Rm, J, vargin )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

%%
y = x(2);
dx = [x(2);
      -(N*N)*(Km*Km)/(J*Rm)*x(2) + (N*Km)/(J*Rm)*u];

end

