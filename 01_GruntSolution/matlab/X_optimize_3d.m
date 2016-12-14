function [ value ] = X_optimize_3d( x, inX, inY, inZ, inR )
    
    count = length(inX);
    value = 0;

    for ii = 1:count
        difference = (sqrt((x(1)-inX(ii))^2+(x(2)-inY(ii))^2+(x(3)-inZ(ii))^2) - inR(ii)).^2;
        value = value + difference;
    end

end

