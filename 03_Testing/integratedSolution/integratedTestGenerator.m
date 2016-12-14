function [] = integratedTestGenerator()

  gridPositions = generateGrid();  
  pathPositions = generateRandomizedPath();
  
  [~,numberOfPathPoints] = size(pathPositions);
  
  for i = 1:numberOfPathPoints
    currentPathPoint = pathPositions(:,i);
    
    % filter closest points
    numberOfPointsToFilter = 10;
    distancesFromPoint = generateDistancesFromPoint(gridPositions,currentPathPoint);
    gridPositionsFiltered = filterClosestNPoints(gridPositions, distancesFromPoint, numberOfPointsToFilter);
    % % %    
    
    distancesFromPointFiltered = generateDistancesFromPoint(gridPositionsFiltered,currentPathPoint);
    anchorDistanceMatrixFiltered = generateDistanceMatrix(gridPositionsFiltered);
    
    
    currentPathPointEstimate = integratedMdsMap(gridPositionsFiltered, anchorDistanceMatrixFiltered, distancesFromPointFiltered);
    
%    disp('--------');
%    disp('current:');
%    disp(currentPathPoint);
%    disp('estimate:');
%    disp(currentPathPointEstimate);
%    disp('distance:');
    disp(euclidDistance(currentPathPoint,currentPathPointEstimate));
  end
end


function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end
