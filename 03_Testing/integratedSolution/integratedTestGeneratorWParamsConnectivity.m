function [totalConnectivity, numberOfPointsWithNeighbor, numberOfPointsWithoutNeighbor] = integratedTestGeneratorWParamsConnectivity(gridPositionJitter, pathNumberOfSplits, numberOfPointsToFilter, radioRange, errorPercentageOfRange)

%  gridPositionJitter = 0.2;  % Random grid
%  pathNumberOfSplits = 5;    % 2^N+1 path points
%  numberOfPointsToFilter = 10;
%  radioRange = 0.5;
%  errorPercentageOfRange = 0.10;

  gridPositions = generateGrid(gridPositionJitter);  
  pathPositions = generateRandomizedPath(pathNumberOfSplits);
  
  [~,numberOfPathPoints] = size(pathPositions);
  connectivity = zeros(numberOfPathPoints,1);
  
  for i = 1:numberOfPathPoints
    currentPathPoint = pathPositions(:,i);
    
    distancesFromPoint = generateDistancesFromPoint(gridPositions,currentPathPoint);
   
    % introduce error
    maximalError = radioRange * errorPercentageOfRange;
    distancesFromPointWithError = introduceErrorToValues(distancesFromPoint, maximalError, 0, Inf);
    % % %
    
    % filter N closest points
    [~, distancesFromPointFiltered] = filterClosestNPoints(gridPositions, distancesFromPointWithError, numberOfPointsToFilter);
    % % %
    
    % filter distances larger than radioRange into INF
    distancesFromPointWithRadioRange = turnLargerValuesIntoInf(distancesFromPointFiltered, radioRange);
    % % %
    
    % calculate nonInfiniteDistances for connectivity
    connectivity(i) = sum(distancesFromPointWithRadioRange ~= Inf);
    % % %
    
  end
  
  numberOfPointsWithoutNeighbor = sum(connectivity == 0);
  numberOfPointsWithNeighbor = numberOfPathPoints - numberOfPointsWithoutNeighbor;
  totalConnectivity = mean(connectivity);
end
