function [ filteredAnchorPositions, filteredDistanceFromDevice ] = filterInfValues(anchorPositions, distanceFromDevice)

  [dimension, numberOfPoints] = size(anchorPositions);
  numberOfInf = sum(distanceFromDevice == Inf);
  
  numberOfFilteredPoints = numberOfPoints - numberOfInf;
  
  filteredAnchorPositions = zeros(dimension,numberOfFilteredPoints);
  filteredDistanceFromDevice = zeros(numberOfFilteredPoints,1);
  
  index = 1;
  
  for i=1:numberOfPoints
    
    if (distanceFromDevice(i) == Inf)
      continue;
    end
    
    filteredDistanceFromDevice(index) = distanceFromDevice(i);
    filteredAnchorPositions(:,index) = anchorPositions(:,i);
    index = index + 1;    
  end   

end

