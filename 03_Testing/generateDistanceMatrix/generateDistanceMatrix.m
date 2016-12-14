function [distanceMatrix] = generateDistanceMatrix(coordinates)

  [~,numberOfPoints] = size(coordinates);
  distanceMatrix = zeros(numberOfPoints,numberOfPoints);
  
  for i = 1:numberOfPoints
    for j = i:numberOfPoints
      distanceMatrix(i,j) = euclidDistance(coordinates(:,i),coordinates(:,j));
      distanceMatrix(j,i) = distanceMatrix(i,j);
    end
  end

end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end

