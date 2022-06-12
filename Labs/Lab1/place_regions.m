function region_centres = place_regions(centre, radius)

y = centre(1);
x = centre(2);
r = radius;


% From top left -> Top right -> Mid left -> ... -> Bot right
centre_x= [x-2*r, x, x+2*r,x-2*r, x, x+2*r, x-2*r, x, x+2*r];
centre_y= [y-2*r, y-2*r, y-2*r,y, y, y, y+2*r, y+2*r, y+2*r];


region_centres=[centre_x; centre_y]; 

end

