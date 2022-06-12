function [y1, y2, tt] = rmag44fRK2( h )

A = 1;
w = pi;
T = 10;
t = T / h;

y = zeros(4,t);

Am = [ 0        0         1       0;
      0        0         0       1;
     -700      700      -52.84   0;
      247.92  -247.92    0       0];
Bm = [0; 0; 98.4; 0];

for n = 2:1:t
    k1 = Am*y(:,(n-1)) + Bm*A*sin(w*h*(n-1));
    y1 = y(:,(n-1)) + k1*h*0.5;
    k2 = Am*y1 + Bm*A*sin(w*h*(n-1) + h*0.5);
    y(:,n) = y(:,n-1) + h*k2;
end

tt = 0:h:T-h;
y1 = y(1,:);
y2 = y(2,:) - y(1,:);

end