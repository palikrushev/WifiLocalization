function [ centeredPointsSet ] = centerPointsSet( pointsSet, center )

  [~, numberOfPoints] = size(pointsSet);
  centeredPointsSet = pointsSet;
  
  for ii = 1:numberOfPoints
    centeredPointsSet(:,ii) = centeredPointsSet(:,ii) - center;
  end

end