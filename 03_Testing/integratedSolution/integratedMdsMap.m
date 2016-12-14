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

function [ fullDistanceMatrix ] = fillAllDistances( distanceMatrix )

  fullDistanceMatrix = floydWarshall(distanceMatrix);

end

function [fullDistanceMatrix]=floydWarshall(distanceMatrix)

  % fills the INF distances with values, ONLY modifies INF distances
  % distanceMatrix: NxN square distance matrix

  N1 = length(distanceMatrix(:,1));
  N2 = length(distanceMatrix(1,:));

  if (N1 ~= N2)
    error('Matrix is not square');
  end

  N=N1;
  fullDistanceMatrix=distanceMatrix;

  for k=1:N
      for i=1:N
          for j=1:N
              if (distanceMatrix(i,j) == inf) && (fullDistanceMatrix(i,j) > fullDistanceMatrix(i,k) + fullDistanceMatrix(k,j))
                  fullDistanceMatrix(i,j) = fullDistanceMatrix(i,k) + fullDistanceMatrix(k,j);
              end
          end
      end
  end

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

