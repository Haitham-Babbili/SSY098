function [ y1, y2, tt ] = rmag42fAB2( h )

A = 1;
w = pi;
T = 10;
t = T / h;

y = zeros(4,t);
dy = zeros(4,t);

Am = [ 0        0         1       0;
      0        0         0       1;
     -700      700      -52.84   0;
      247.92  -247.92    0       0];
Bm = [0; 0; 98.4; 0];

dy(:,1) = Am*y(:,1) + Bm*A*sin(w*h*0);
y(:,2) = y(:,1) + h*dy(:,1);
dy(:,2) = Am*y(:,2) + Bm*A*sin(w*h*1);
y(:,3) = (1 + 1.5*h*(1 - 2*h))*y(:,1) - 0.5*h*[1;1;1;1];
dy(:,3) = Am*y(:,2) + Bm*A*sin(w*h*2);
for n = 4:1:t
    y(:,n) = y(:,n - 1) + 0.5*h*(3*dy(:,n-1) - dy(:,n-2));
    dy(:,n) = Am*y(:,n) + Bm*A*sin(w*h*(n-1));
end

tt = 0:h:T-h;
y1 = y(1,:);
y2 = y(2,:) - y(1,:);

end