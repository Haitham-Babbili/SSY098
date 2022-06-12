function [ Xfilt, P ] = kalmfilt( Y, A, C, Q, R, x0, P0 )
%kalmfilt - Kalman Filter
% Input Parameters:
%   Y:  Measured Signal
%   A:  System Matrix
%   C:  Measurement Matrix
%   Q:  Covariance Matrix of Process Noise
%   R:  Covariance Matrix of Measurement Noise,
%   x0: Estimate of x(0)            - Default All Zeros
%   P0: Error Covariance for x(0)   - Default Identity Matrix
% Output Variables:
%   Xfilt: Kalman-filtered Estimate of the States
%   P:     Covariance Matrix of Last Xfilt Element
% 10/12/2016

[p, N] = size(Y);       % N: Number of Samples, p: Number of 'Sensors'
n = length(A);          % n: System Order
Xpred = zeros(n, N+1);  % Kalman Predicted States
Xfilt = zeros(n, N+1);  % Kalman Filtered States

if nargin < 7
    P0 = eye(n);        % Default Initial Covariance
end
if nargin < 6
    x0 = zeros(n, 1);   % Default Initial States
end

% Filter initialization
Xpred(:, 1) = x0;       % Index 1 Means Time 0
P = P0;                 % Initial Covariance Matrix

% Kalman Filter Iterations
for t = 1 : N
    % Measurement Update
    Xfilt(:,t) = Xpred(:,t)+P*C'*(C*P*C'+R)^-1*(Y(:,t)-C*Xpred(:,t));
    P = P-P*C'*(C*P*C'+R)^-1*C*P;
    % Time Update
    Xpred(:,t+1) = A*Xfilt(:,t);
    P = A*P*A'+Q;
end
 
end

