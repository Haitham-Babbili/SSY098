function my_net = build_my_network()
%%BUILD_MY_NETWORK 
%   Output :
%   - my_net : a 13-layer network
%   All layers:
%   # 1  : CONV 4 x 4 x 1 x 20
%   # 2  : RELU
%   # 3  : POOL
%   # 4  : CONV 3 x 3 x 20 x 50
%   # 5  : RELU
%   # 6  : POOL
%   # 7  : CONV 3 x 3 x 50 x 200
%   # 8  : RELU
%   # 9  : CONV 3 x 3 x 200 x 500
%   # 10 : RELU
%   # 11 : DROPOUT
%   # 12 : CONV 2 x 2 x 500 x 26
%   # 13 : SOFTMAX
% Author: Qixun Qu

% Set a scalar
f = 1/4;

% Initialize the met
my_net.layers = {};

% #1 Convolution  4  x 4  x 1  x 20
% input  : matrix 32 x 32 x 1  x 100
% output : matrix 29 x 29 x 20 x 100
my_net.layers{end+1} = ... 
       struct('type', 'conv', ...
              'weights', ... 
              {{f*randn(4, 4, 1, 20, 'single') / sqrt(4*4), ...
                zeros(1, 20, 'single')}}, ...
              'stride', 1, ...
              'pad', 0);

% #2 RELU
my_net.layers{end+1} = struct('type', 'relu');

% #3 Max Pooling
% input  : 29 x 29 x 20 x 100
% output : 14 x 14 x 20 x 100
my_net.layers{end+1} = struct('type', 'pool', ...
                              'method', 'max', ...
                              'pool', [2 2], ...
                              'stride', 2, ...
                              'pad', 0);

% #4 Convolution  3  x 3  x 20 x 50
% input  : matrix 14 x 14 x 20 x 100
% output : matrix 12 x 12 x 50 x 100
my_net.layers{end+1} = ... 
       struct('type', 'conv', ...
              'weights', ... 
              {{f*randn(3, 3, 20, 50, 'single') / sqrt(3*3*20), ...
                zeros(1, 50, 'single')}}, ...
              'stride', 1, ...
              'pad', 0);

% #5 RELU
my_net.layers{end+1} = struct('type', 'relu');

% #6 Max Pooling
% input  : 12 x 12 x 50 x 100
% output : 6  x 6  x 50 x 100
my_net.layers{end+1} = struct('type', 'pool', ...
                              'method', 'max', ...
                              'pool', [2 2], ...
                              'stride', 2, ...
                              'pad', 0);

% #7 Convolution  3 x 3 x 50  x 200
% input  : matrix 6 x 6 x 50  x 100
% output : matrix 4 x 4 x 200 x 100
my_net.layers{end+1} = ... 
       struct('type', 'conv', ...
              'weights', ...
              {{f*randn(3, 3, 50, 200, 'single') / sqrt(3*3*50), ...
                zeros(1, 200, 'single')}}, ...
              'stride', 1, ...
              'pad', 0);

% #8 RELU
my_net.layers{end+1} = struct('type', 'relu');

% #9 Convolution  3 x 3 x 200 x 500
% input  : matrix 4 x 4 x 200 x 100
% output : matrix 2 x 2 x 500 x 100
my_net.layers{end+1} = ... 
       struct('type', 'conv', ...
              'weights', ...
              {{f*randn(3, 3, 200, 500, 'single') / sqrt(3*3*200), ...
                zeros(1, 500, 'single')}}, ...
              'stride', 1, ...
              'pad', 0);

% #10 RELU
my_net.layers{end+1} = struct('type', 'relu');

% #11 Dropout
my_net.layers{end+1} = struct('type', 'dropout',...
                              'rate', 0.5');

% #12 Convolution  2 x 2 x 500 x 26
% input  : matrix  2 x 2 x 500 x 100
% output : matrix  1 x 1 x 26  x 100
my_net.layers{end+1} = ... 
       struct('type', 'conv', ...
              'weights', ...
              {{f*randn(2, 2, 500, 26, 'single') / sqrt(2*2*500), ...
                zeros(1, 26, 'single')}}, ...
              'stride', 1, ...
              'pad', 0);

% #13 Softmax
my_net.layers{end+1} = struct('type', 'softmaxloss') ;

my_net = vl_simplenn_tidy(my_net) ;

end