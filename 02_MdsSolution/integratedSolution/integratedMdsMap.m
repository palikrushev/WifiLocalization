function [devicePosition] = integratedMdsMap(anchorPositions, distancesBetweenAnchors, distanceFromDevice)

  % The first node of the distance matrix is the unknown device
  distanceMatrix = horzcat(distanceFromDevice, distancesBetweenAnchors);
  distanceMatrix = vertcat(horzcat(0, transpose(distanceFromDevice)), distanceMatrix);
  
  % Find all shortest paths ONLY for INF values
  fullDistanceMatrix = fillAllDistances(distanceMatrix);
  
  % Perform classic mdscale
  dimensions = length(anchorPositions(:,1));
  rescaledPositions = mdsClassic(fullDistanceMatrix, dimensions);
  
  % Extract separate rescaled positions for the anchors and for the device
  anchorRescaledPositions = rescaledPositions(:,2:end);
  deviceRescaledPosition = rescaledPositions(:,1);
  
  % Find rotationMatrix and translationVector from the anchor nodes
  [rotationMatrix, translationVector] = findRotationTranslation(anchorPositions, anchorRescaledPositions);
  
  % Calculate device location
  devicePosition = rotationMatrix * deviceRescaledPosition + translationVector;
end

