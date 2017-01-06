function [error] = calculateTotalError(pathPositions, pathPositionEstimates, radioRange)
  
  [~,numberOfPathPoints] = size(pathPositions);
  errorSum = 0;
  
  for i=1:numberOfPathPoints
    errorSum = errorSum + euclidDistance(pathPositions(:,i),pathPositionEstimates(:,i));
  end
  
  error = errorSum/(numberOfPathPoints * radioRange);
end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end