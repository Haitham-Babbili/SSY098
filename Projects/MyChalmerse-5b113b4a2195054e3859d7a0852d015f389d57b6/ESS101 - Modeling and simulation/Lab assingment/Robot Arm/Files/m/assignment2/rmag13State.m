function [RMH, RMRes] = rmag13State( N, Rm, Klin, RMt )
%RMStateSpace Abstract of the fnunction
%   This function is used to vary some parameters 
%   of robot arm's state space.
%   Here, three arguments can be altered to observe
%   the changes of the response.
%   ---------------------------------------------------
%   Returns    |    Meaning
%   ---------------------------------------------------
%   RMH        |    Transform Function
%   RMRes      |    Step Response
%   ---------------------------------------------------
%   Arguments  |    Meaning           |   Default Value
%   ---------------------------------------------------
%   N          |    Gear Ratio        |   64
%   Rm         |    Resistor          |   3.21
%   Klin       |    Sprint Constant   |   1.19
%   RMt        |    Sampling Time     |   0:0.001:10
%   ---------------------------------------------------
%   Usage samples
%   ---------------------------------------------------
%   N = 100;   Rm = 10;   Klin = 5;
%   No Modification       RMStateSpace()
%   Modify N              RMStateSpace(N)
%   Modify N & Rm         RMStateSpace(N, Rm)
%   Modify N & Rm & Klin  RMStateSpace(N, Rm, Klin)
%   Get Returns           [RMH, RMRes] = RMStateSpace()
%   ---------------------------------------------------
%   2016/10/13 22:00

%% Set Default Values
if (nargin < 4)
    RMt = 0:0.001:10; end
if (nargin < 3)
    Klin = 1.19;      end
if (nargin < 2) 
    Rm   = 3.21;      end
if (nargin < 1) 
    N    = 64;        end
% Other constants
J1   = 1.7e-3;
J2   = 4.83e-3;
Km   = 8.39e-3;

%% Calculate transform function
% State space model
RMA = [ 0        0         1                   0;
      0        0         0                   1;
     -Klin/J1  Klin/J1   -N^2*Km^2/(J1*Rm)   0;
      Klin/J2  -Klin/J2  0                   0];
RMB = [0; 0; N*Km/(J1*Rm); 0];
RMC = [1 0 0 0;    % theta1
       0 0 1 0;    % dirivative of theta1
      -1 1 0 0];   % alpha = theta2 - theta1
RMD = [0; 0; 0];
RMG = ss(RMA, RMB, RMC, RMD);
% Get transform function
RMH = tf(RMG);

%% Get response
% Step response
RMRes = step(RMG, RMt);
RMRes(:,1) = RMRes(:,1) * (180/pi);
RMRes(:,3) = RMRes(:,3) * (180/pi);
% RMRes(:,1) contains values of theta1
% RMRes(:,2) contains values of theta1's dirivative
% RMRes(:,3) contains values of alpha

end

