function [distance] = single_point_circle(pX,pY,cX,cY,R)
    distance = abs(sqrt((pX-cX)^2+(pY-cY)^2) - R);
end
