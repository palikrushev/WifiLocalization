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



