function [devicePosition] = integratedMdsMap(anchorPositions, distanceFromDevice)

  % Filter infinite values
  [filteredAnchorPositions, filteredDistanceFromDevice] = filterInfValues(anchorPositions, distanceFromDevice);
  
  try
    % Try MDS-MAP Algoritthm
    devicePosition = mdsMapAlgorithm(filteredAnchorPositions, filteredDistanceFromDevice);
  catch exception
    % If it fails, just find the centroid
    devicePosition = weightedCentroid(filteredAnchorPositions, filteredDistanceFromDevice);
  end
  
end

function [devicePosition] = mdsMapAlgorithm(anchorPositions, distanceFromDevice)

  % Calculate all distances between anchors
  distancesBetweenAnchors = generateDistanceMatrix(anchorPositions);
    
  % The first node of the distance matrix is the unknown device
  distanceMatrix = horzcat(distanceFromDevice, distancesBetweenAnchors);
  distanceMatrix = vertcat(horzcat(0, transpose(distanceFromDevice)), distanceMatrix);
  
  % Find all shortest paths ONLY for INF values
  % distanceMatrix = fillAllDistances(distanceMatrix);
  % this is now DISABLED, instead weighted centroid is used
  
  % Perform classic mdscale
  dimensions = length(anchorPositions(:,1));
  rescaledPositions = mdsClassic(distanceMatrix, dimensions);
  
  % Extract separate rescaled positions for the anchors and for the device
  anchorRescaledPositions = rescaledPositions(:,2:end);
  deviceRescaledPosition = rescaledPositions(:,1);
  
  % Find rotationMatrix and translationVector from the anchor nodes
  [rotationMatrix, translationVector] = findRotationTranslation(anchorRescaledPositions, anchorPositions);
  
  % Calculate device location
  devicePosition = rotationMatrix * deviceRescaledPosition + translationVector;
end

