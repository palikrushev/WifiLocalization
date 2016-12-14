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