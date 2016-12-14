function [result] = centroid(pointsSet)

  [dimension, ~] = size(pointsSet);
  result = zeros(dimension, 1);

  for ii = 1:dimension
    result(ii,1) = mean(pointsSet(ii,:));
  end

end