function [ distances ] = calculateAllDistances( gridPositions )

  [~, numberOfPoints] = size(gridPositions);
  
  distances = zeros((numberOfPoints * (numberOfPoints-1)) / 2 , 1);
  index = 1;

  for i = 1:numberOfPoints
    for j = i+1:numberOfPoints
      distances(index) = euclidDistance(gridPositions(:,i),gridPositions(:,j));
      index = index + 1;
    end
  end

end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end
