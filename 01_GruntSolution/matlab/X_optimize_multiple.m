function [ value ] = X_optimize_multiple( x, inX, inY, inR )
    
    count = size(inX);
    value = 0;

    for ii = 1:count
        value = value + (sqrt((x(1)-inX(ii))^2+(x(2)-inY(ii))^2) - inR(ii)).^2;
    end

end

