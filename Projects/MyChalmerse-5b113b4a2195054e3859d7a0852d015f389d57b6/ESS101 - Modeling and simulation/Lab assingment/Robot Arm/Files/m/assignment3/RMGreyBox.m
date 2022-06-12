function [ RMA, RMB, RMC, RMD ] = ...
    RMGreyBox( N, Km, Rm, J, T )
% Model Structure
RMA = [0 1; 0 -(N*N)*(Km*Km)/(J*Rm)];
RMB = [0; (N*Km)/(J*Rm)];
RMC = [1 0];
RMD = zeros(1,1);
end




