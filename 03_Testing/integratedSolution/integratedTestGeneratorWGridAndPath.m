function [pathPositionEstimates] = integratedTestGeneratorWGridAndPath(gridPositions,pathPositions)

  radioRange = 0.5;
  errorPercentageOfRange = 0.10;
  numberOfPointsToFilter = 30;

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
    
    anchorDistanceMatrixFiltered = generateDistanceMatrix(gridPositionsFiltered); 
    currentPathPointEstimate = integratedMdsMap(gridPositionsFiltered, anchorDistanceMatrixFiltered, distancesFromPointWithRadioRange);
    
    pathPositionEstimates(:,i) = currentPathPointEstimate;
%    disp('--------');
%    disp('current:');
%    disp(currentPathPoint);
%    disp('estimate:');
%    disp(currentPathPointEstimate);
%    disp('distance:');
    disp(euclidDistance(currentPathPoint,currentPathPointEstimate));
  end
  
  %visualize(pathPositions, pathPositionEstimates);
  visualizeGridPathAndEstimate(gridPositions, pathPositions, pathPositionEstimates);
  
  totalError = calculateTotalError(pathPositions, pathPositionEstimates, radioRange);
  totalConnectivity = mean(connectivity);
  disp('Total error:');
  disp(totalError); 
  disp('Total connectivity:');
  disp(totalConnectivity); 
end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end
