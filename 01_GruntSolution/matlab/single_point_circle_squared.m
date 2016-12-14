function [distance] = single_point_circle_squared(pX,pY,cX,cY,R)
    distance = (sqrt((pX-cX)^2+(pY-cY)^2) - R)^2;
end
