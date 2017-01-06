function [gridPositionsFiltered, distancesFromPointFiltered] = filterClosestNPoints(gridPositions, distancesFromPoint, numberOfPointsToFilter)

  if (numberOfPointsToFilter >= length(distancesFromPoint))
    gridPositionsFiltered = gridPositions;
    distancesFromPointFiltered = distancesFromPoint;
    return;
  end
  
  [dimension,~] = size(gridPositions);
  
  gridPositionsFiltered = zeros(dimension, numberOfPointsToFilter);
  distancesFromPointFiltered = zeros(numberOfPointsToFilter,1);
  
  for i=1:numberOfPointsToFilter
    [value,index] = min(distancesFromPoint);
    distancesFromPoint(index) = Inf;
    gridPositionsFiltered(:,i) = gridPositions(:,index);
    distancesFromPointFiltered(i,1) = value;
  end

end

