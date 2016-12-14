function [pathPositions] = generateRandomizedPath(numberOfSplits)

% Creates path with 2^numberOfSplits+1 points
  if(~exist('numberOfSplits','var'))
    numberOfSplits = 5;
  end

  start = [0;rand;rand];
  final = [1;rand;rand];
  
  pathPositions = splitPathByX(start,final,numberOfSplits);
  pathPositions = horzcat(start, pathPositions, final);
  
  plot3(pathPositions(1,:),pathPositions(2,:),pathPositions(3,:));
end

%dont forget to add first and second point afterwards
function [pathPositions] = splitPathByX(firstPoint,secondPoint,splitsRemaining)
  
  middlePoint = findMidPointWithVariation(firstPoint,secondPoint);
  pathPositions = middlePoint;
    
  if (splitsRemaining > 1)
    pathPositionsLeft = splitPathByX(firstPoint,middlePoint,splitsRemaining-1);
    pathPositionsRight = splitPathByX(middlePoint,secondPoint,splitsRemaining-1);
    pathPositions = horzcat(pathPositionsLeft, middlePoint, pathPositionsRight);
  end

end

function [adjustedMidPoint] = findMidPointWithVariation(firstPoint,secondPoint)

  midPoint = (firstPoint + secondPoint) / 2;
  distanceByX = abs(firstPoint(1) - secondPoint(1));
  adjustedMidPoint = midPoint;
    
  % mod X by at most distanceByX/10
  while 1
    variation = (rand-0.5) * 2 * (distanceByX / 10);
    adjustedMidPoint(1) = midPoint(1) + variation;
    if (withinBounds(adjustedMidPoint(1)))
      break;
    end
  end
  
  
  % mod Y by at most distanceByX
  while 1
    variation = (rand-0.5) * 2 * distanceByX;
    adjustedMidPoint(2) = midPoint(2) + variation;
    if (withinBounds(adjustedMidPoint(2)))
      break;
    end
  end
    
  % mod Z by at most distanceByX
  while 1
    variation = (rand-0.5) * 2 * distanceByX;
    adjustedMidPoint(3) = midPoint(3) + variation;
    if (withinBounds(adjustedMidPoint(3)))
      break;
    end
  end
  
end

function [check] = withinBounds(number)
  check = number >= 0 && number <= 1;
end