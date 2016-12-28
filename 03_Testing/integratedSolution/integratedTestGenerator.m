function [totalError,totalConnectivity,gridPositions,pathPositions] = integratedTestGenerator()

  gridPositionJitter = 0.2;  % Random grid
  pathNumberOfSplits = 5;    % 2^N+1 path points
  numberOfPointsToFilter = 10;
  radioRange = 0.2;
  errorPercentageOfRange = 0.10;

  gridPositions = generateGrid(gridPositionJitter);  
  pathPositions = generateRandomizedPath(pathNumberOfSplits);
  pathPositionEstimates = pathPositions;
  
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
    [gridPositionsFiltered, distancesFromPointFiltered] = filterClosestNPoints(gridPositions, distancesFromPointWithError, numberOfPointsToFilter);
    % % %
    
    % filter distances larger than radioRange into INF
    distancesFromPointWithRadioRange = turnLargerValuesIntoInf(distancesFromPointFiltered, radioRange);
    % % %
    
    % calculate nonInfiniteDistances for connectivity
    connectivity(i) = sum(distancesFromPointWithRadioRange ~= Inf);
    % % %
     
    currentPathPointEstimate = integratedMdsMap(gridPositionsFiltered, distancesFromPointWithRadioRange);
    
    pathPositionEstimates(:,i) = currentPathPointEstimate;
%    disp('--------');
%    disp('current:');
%    disp(currentPathPoint);
%    disp('estimate:');
%    disp(currentPathPointEstimate);
%    disp('distance:');
    disp(euclidDistance(currentPathPoint,currentPathPointEstimate));
  end
  
  visualize(pathPositions, pathPositionEstimates);
  
  totalError = calculateTotalError(pathPositions, pathPositionEstimates, radioRange);
  totalConnectivity = mean(connectivity);
  disp('Total error:');
  disp(totalError); 
end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end
