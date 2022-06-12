function region_centre = place_regions(centre, radius)
%center is an array with 2 elements describing the center location of our
%3x3 mesh. radius is the distance from the center of each square in the 3x3
%to the edge.
y = centre(1); %takes first element from center and assigns it to y
x = centre(2); %takes second elemnt from center and assigns it to x

centres_y = [ y-2*radius-1, y-2*radius-1, y-2*radius-1, y, y, y, y+2*radius+1, y+2*radius+1,y+2*radius+1];
centres_x = [ x-2*radius-1, x, x+2*radius+1, x-2*radius, x, x+2*radius, x-2*radius-1, x, x+2*radius+1];
%to create 3x3 squares with the same radius we will have the same y values 
%for the squares in the same row and the same x value for the squares in 
%the same column will have three different values 


region_centre=[centres_y; centres_x];