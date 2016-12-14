function [outR] = Y_calculate_R_with_error( points, inX, inY, inZ, max_error )
% max_error of 1 is upto 100% error of signal strength

    nCircles = length(inX);
    [nPoints, ~] = size(points);
    outR = zeros(nPoints, nCircles);
    
    for ii = 1:nPoints
        for jj = 1:nCircles
            distance = get_distance(points(ii, 1), points(ii, 2), points(ii, 3), inX(jj), inY(jj), inZ(jj));
            error = distance * max_error * (rand() - 0.5) * 2;
            distance = distance + error;
            outR(ii, jj) = distance;
        end
    end

end

