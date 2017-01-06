function [ centroid ] = weightedCentroid( anchorPositions, distanceFromDevice )

  % Calculated the weighted centroid while ignoring infinite values.

  [dimension, numberOfPoints] = size(anchorPositions);
  
  if (numberOfPoints == 0)
    centroid = zeros(dimension,1) + 0.5;
    return;
  end

  weightSum = 0;
  centroidSum = zeros(dimension,1);
  for i = 1:numberOfPoints
    if(distanceFromDevice(i) == Inf)
      continue;
    end;
    
    % 0.000001 is added to prevent infinity
    weight = 1 / (distanceFromDevice(i) + 0.000001);
    weightSum = weightSum + weight;
    centroidSum = centroidSum + (anchorPositions(:,i) * weight);
  end
  
  centroid = centroidSum / weightSum;

end