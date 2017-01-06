function [ maxDistance ] = calculateMaxDistance( gridPositions )

  [~, numberOfPoints] = size(gridPositions);
  
  maxDistance = 0;

  for i = 1:numberOfPoints
    for j = i:numberOfPoints
      maxDistance = max(maxDistance, euclidDistance(gridPositions(:,i),gridPositions(:,j)));
    end
  end

end


function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end
