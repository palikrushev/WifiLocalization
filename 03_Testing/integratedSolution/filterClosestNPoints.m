function [ gridPositionsFiltered ] = filterClosestNPoints( gridPositions, distancesFromPoint, numberOfPointsToFilter )

  if (numberOfPointsToFilter >= length(distancesFromPoint))
    gridPositionsFiltered = gridPositions;
    return;
  end
  
  [dimension,~] = size(gridPositions);
  
  gridPositionsFiltered = zeros(dimension, numberOfPointsToFilter);
  
  for i=1:numberOfPointsToFilter
    [~,index] = min(distancesFromPoint);
    distancesFromPoint(index) = Inf;
    gridPositionsFiltered(:,i) = gridPositions(:,index);
  end

end

