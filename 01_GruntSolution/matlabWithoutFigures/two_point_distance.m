function [ distance ] = two_point_distance( x1, y1, z1, x2, y2, z2 )
    distance = sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
end

