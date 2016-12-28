function [devicePosition] = integratedMdsMap(anchorPositions, distanceFromDevice)

  % Filter infinite values
  [filteredAnchorPositions, filteredDistanceFromDevice] = filterInfValues(anchorPositions, distanceFromDevice);
  
  % If there are not enought points to do MDS, find weighted centroid
  [dimension,~] = size(anchorPositions);
  if (length(filteredDistanceFromDevice) <= dimension)
    devicePosition = weightedCentroid(filteredAnchorPositions, filteredDistanceFromDevice);
    return;
  end
  
  % Otherwise go with MDS-MAP Algoritthm
  devicePosition = mdsMapAlgorithm(filteredAnchorPositions, filteredDistanceFromDevice);  
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
  [dimension,~] = size(anchorPositions);
  rescaledPositions = mdsClassic(distanceMatrix, dimension);
  
  % Extract separate rescaled positions for the anchors and for the device
  anchorRescaledPositions = rescaledPositions(:,2:end);
  deviceRescaledPosition = rescaledPositions(:,1);
  
  % Find rotationMatrix and translationVector from the anchor nodes
  [rotationMatrix, translationVector] = findRotationTranslation(anchorRescaledPositions, anchorPositions);
  
  % Calculate device location
  devicePosition = rotationMatrix * deviceRescaledPosition + translationVector;
end

function [ filteredAnchorPositions, filteredDistanceFromDevice ] = filterInfValues(anchorPositions, distanceFromDevice)

  [dimension, numberOfPoints] = size(anchorPositions);
  numberOfInf = sum(distanceFromDevice == Inf);
  
  numberOfFilteredPoints = numberOfPoints - numberOfInf;
  
  filteredAnchorPositions = zeros(dimension,numberOfFilteredPoints);
  filteredDistanceFromDevice = zeros(numberOfFilteredPoints,1);
  
  index = 1;
  
  for i=1:numberOfPoints
    
    if (distanceFromDevice(i) == Inf)
      continue;
    end
    
    filteredDistanceFromDevice(index) = distanceFromDevice(i);
    filteredAnchorPositions(:,index) = anchorPositions(:,i);
    index = index + 1;    
  end   

end

function [ centroid ] = weightedCentroid( anchorPositions, distanceFromDevice )

  % Calculated the weighted centroid while ignoring infinite values.

  [dimension, numberOfPoints] = size(anchorPositions);
  
  if (numberOfPoints == 0)
    centroid = [0.5;0.5;0.5];
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

function [distanceMatrix] = generateDistanceMatrix(coordinates)

  [~,numberOfPoints] = size(coordinates);
  distanceMatrix = zeros(numberOfPoints,numberOfPoints);
  
  for i = 1:numberOfPoints
    for j = i:numberOfPoints
      distanceMatrix(i,j) = euclidDistance(coordinates(:,i),coordinates(:,j));
      distanceMatrix(j,i) = distanceMatrix(i,j);
    end
  end

end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end

function [rotationMatrix, translationVector]=findRotationTranslation(startPos, finalPos)

  % startPos/finalPos: DIMxN matrices which describe the point sets of
  % the starting and ending position

  % Compute weighted centroids
  startPosCentroid = centroid(startPos);
  finalPosCentroid = centroid(finalPos);

  % Compute centered vectors
  startPosCentered = centerPointsSet(startPos, startPosCentroid);
  finalPosCentered = centerPointsSet(finalPos, finalPosCentroid);
  
  % Compute DIMxDIM covariance matrix
  H = startPosCentered * transpose(finalPosCentered);  
  
  % Compute Singular Value Decomposition SVD
  [U,~,V] = svd(H);
  
  % Compute rotation matrix
  rotationMatrix = V*transpose(U);
  
  % Compute optimal translation
  translationVector = finalPosCentroid - rotationMatrix * startPosCentroid;

end

function [result] = centroid(pointsSet)

  [dimension, ~] = size(pointsSet);
  result = zeros(dimension, 1);

  for ii = 1:dimension
    result(ii,1) = mean(pointsSet(ii,:));
  end

end

function [ centeredPointsSet ] = centerPointsSet( pointsSet, center )

  [~, numberOfPoints] = size(pointsSet);
  centeredPointsSet = pointsSet;
  
  for ii = 1:numberOfPoints
    centeredPointsSet(:,ii) = centeredPointsSet(:,ii) - center;
  end

end

function [scaledMatrix] = mdsClassic(distanceMatrix, dimensions)

  scaledMatrix = transpose(mdscale(distanceMatrix, dimensions));

end

