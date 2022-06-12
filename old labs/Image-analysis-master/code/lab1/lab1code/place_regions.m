function region_centres = place_regions(centre,radius)
% given [y;x] centre of a region of interest
% create 3*3 regions with radius=radius around the centre
% output the centre points of all the 
y=centre(1);
x=centre(2);
D=2*radius+1;

region_centres=[y-D y y+D y-D y y+D y-D y y+D;
    x-D x-D x-D x x x x+D x+D x+D];
end