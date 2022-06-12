function histogram=gradient_histogram(grad_x,grad_y)
bin=zeros(8,1);
for i=1:size(grad_x,1)
    for j=1:size(grad_x,2)
dir=atan2(grad_y(i,j),grad_x(i,j)); % direction in radians from the positive x-axis
len=sqrt(grad_x(i,j)^2+grad_y(i,j)^2);
if dir<=pi/4 && dir>0
    bin(1)=bin(1)+len;
else if dir<=2*pi/4 && dir>pi/4
        bin(2)=bin(2)+len;
    else if dir<=3*pi/4 && dir>2*pi/4
            bin(3)=bin(3)+len;
        else if dir<=pi && dir>3*pi/4
                bin(4)=bin(4)+len;
                % here we change it up a bit since arctan takes values in
                % [-pi,pi]; so now we go from -pi to 0 to keep consistent
            else if dir<=-3*pi/4 && dir>-pi
                    bin(5)=bin(5)+len;
                else if dir<=-2*pi/4 && dir>-3*pi/4
                        bin(6)=bin(6)+len;
                    else if dir<=-pi/4 && dir>-2*pi/4
                            bin(7)=bin(7)+len;
                        else
                            bin(8)=bin(8)+len;
                        end
                    end
                end
            end
        end
    end
end
% end of stupid if case
    end
end
histogram=bin;
end