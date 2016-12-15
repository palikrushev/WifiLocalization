function [] = integratedTestGenerator()

  gridPositions = generateGrid();  
  pathPositions = generateRandomizedPath();
  
  [~,numberOfPathPoints] = size(pathPositions);
  
  numberOfPointsToFilter = 10;
  radioRange = 0.5;
  errorPercentageOfRange = 0.01;
  
  for i = 1:numberOfPathPoints
    currentPathPoint = pathPositions(:,i);
    
    distancesFromPoint = generateDistancesFromPoint(gridPositions,currentPathPoint);
   
    % introduce error
    maximalError = radioRange * errorPercentageOfRange;
    distancesFromPointWithError = introduceErrorToValues(distancesFromPoint, maximalError, 0, Inf);
    % % %
    
    % filter N closest points
    [gridPositionsFiltered, distancesFromPointFiltered] = filterClosestNPoints(gridPositions, distancesFromPointWithError, numberOfPointsToFilter);
    % % %
    
    % filter distances larger than radioRange into INF
    distancesFromPointWithRadioRange = turnLargerValuesIntoInf(distancesFromPointFiltered, radioRange);
    % % %
    
    anchorDistanceMatrixFiltered = generateDistanceMatrix(gridPositionsFiltered); 
    currentPathPointEstimate = integratedMdsMap(gridPositionsFiltered, anchorDistanceMatrixFiltered, distancesFromPointWithRadioRange);
    
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
