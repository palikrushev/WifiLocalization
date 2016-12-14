function [distance] = point_to_circle_distance(pX,pY,cX,cY,R)

    [iMax,jMax] = size(pX);

    distance = zeros(iMax,jMax);

    for ii = 1:iMax
        for jj = 1:jMax

            distance(ii,jj) = abs(sqrt((pX(ii,jj)-cX)^2+(pY(ii,jj)-cY)^2) - R);

        end
    end

end
