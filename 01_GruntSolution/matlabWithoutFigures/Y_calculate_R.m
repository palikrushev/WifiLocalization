function [outR] = Y_calculate_R( points, inX, inY, inZ )

    nCircles = length(inX);
    [nPoints, ~] = size(points);
    outR = zeros(nPoints, nCircles);
    
    for ii = 1:nPoints
        for jj = 1:nCircles
            outR(ii, jj) = get_distance(points(ii, 1), points(ii, 2), points(ii, 3), inX(jj), inY(jj), inZ(jj));
        end
    end

end

