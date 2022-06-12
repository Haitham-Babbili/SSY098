function region_centres = place_regions(centre,radius);
% - INPUT
% Where the center should be, radius of regions
% 
% - OUTPUT 
% Places as region_centres(1,:) = x-coordinate
% Places as region_centres(2,:) = y-coordinate

y = centre(1);
x = centre(2);
r = radius;

x_min = 2*r;
x_max = 2*r;
y_min = 2*r;
y_max = 2*r;

% From top left -> Top right -> Mid left -> ... -> Bot right
x_cent= [x-x_min, x, x+x_min,          x-x_min, x, x+x_max, x-x_max, x, x+x_max];
y_cent= [y-y_min, y-y_min, y-y_min,    y, y, y,             y+y_max, y+y_max, y+y_max];

region_centres=[x_cent;
                y_cent]; 
end

