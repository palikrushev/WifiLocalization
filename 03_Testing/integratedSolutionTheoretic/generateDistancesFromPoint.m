function [ distancesFromPoint ] = generateDistancesFromPoint(gridPositions,point)

  [~,numberOfPoints] = size(gridPositions);
  distancesFromPoint = zeros(numberOfPoints,1);
  
  for i = 1:numberOfPoints
    distancesFromPoint(i) = euclidDistance(gridPositions(:,i),point);
  end
end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end
