function pos_tilde = transform_coordinates(pos)

%pos_tilde = transformCoordinates;

[dx,dy] = getDelta(pos(1),pos(2));

pos_tilde(1) = pos(1) + dx;
pos_tilde(2) = pos(2) + dy;

end

function [dx,dy] = getDelta(x,y)

x = min(max(x,1),16);
y = min(max(y,1),16);

rowd = [0  0  0  0  0  1  1  1  1  1  1  0  0  0  0  0;
  	   -2  0  0  0  0  1  1  1  1 -1 -1  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0.2;
  		0  0  0  0  0  2  2  0  0  0  0  0  0  0  0  0;
  		0  0  0 -1 -1 -1 -1 -1 -1 -1 -1 -1  0  0 -1  0;
  		0  0 -2 -2  0 -1 -1 -1 -1 -1 -1 -1 -2 -2 -2  0;
  		0  0  0  0  0  0 -2  0  0 -2  0  0  0  0  0  0;
  		0  0  0  0  0  0  2  0  0  2  0  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
  		0  0  0  0 -1 -1 -1 -1 -1 -1 -1 -1  0  0  0  0;
  		0  0  0  0 -1 -1 -1 -1 -1 -1 -1 -1  0  0  0  0];

cold =[ 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
		0  0  0  0  0  0  0  0 -1  0  0  0  0  0  0  0;
 		0  0  1 -1 -2  0  0  0 -1  0  0  0 -1 -1  0  0;
  		0  2  0 -1  0  0  0  0 -1 -2  0  0 -1  0 -2  0;
  		0  2  0  1  0 -3  2  1  0 -2 -3  0 -1  0 -2  0;
  		3  3  2  1 -2 -3  2  1  0  0 -3 -4 -5 -6 -7 -3;
  		3  3  2  1 -2 -3  2  1  0  0 -3 -4 -1  0 -7 -3.1;
  		3  0  2  1 -2 -3  2  1  0  0 -3  0 -1  0  0 -3;
  		3  0  0  1  0  0  0  1  0 -2 -3  0 -1  0  0 -3;
  		3  0  0  1  0  0  0  0 -1 -2 -3 -4  1  0 -7 -3;
  		3  0  2  1 -1  0  0  0  0  0  0  0 -5 -6 -7 -3;
  		0  2  1  0  0  0  0  0  0  0  0  0  0 -1 -2  0;
  		0  0  1 -1  0  0  0  0  0  0  0  0 -1 -1  0  0;
  		0  0  1 -1  0  0  0  0  0  0  0  0 -1 -1  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;
  		0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0];
    
    dy = rowd(y,x);
    dx = cold(y,x);
end