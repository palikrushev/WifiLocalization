function [scaledMatrix] = mdsClassic(distanceMatrix, dimensions)

  scaledMatrix = transpose(mdscale(distanceMatrix, dimensions));

end

