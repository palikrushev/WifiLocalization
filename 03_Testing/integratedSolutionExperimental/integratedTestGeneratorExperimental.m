function [] = integratedTestGeneratorExperimental(gridPositions, measurements)

  [dimension,numberOfPoints] = size(gridPositions);

  totalDistance = 0;
  errors = zeros(numberOfPoints);
  estimates = zeros(dimension,numberOfPoints);
  radioRange = calculateMaxDistance(gridPositions);
  
  for i = 1:numberOfPoints
    
    currentDevicePosition = gridPositions(:,i);
    currentDeviceRssiMeasurements = takeSingleMeasurementColumn(measurements,i);
    currentDeviceDistanceMeasurements = convertMeasurementsToDistances(currentDeviceRssiMeasurements);
    
    filteredGridPositions = filterGridPositions(gridPositions,i);
    
    currentEstimate = integratedMdsMap(filteredGridPositions, currentDeviceDistanceMeasurements);
    estimates(:,i) = currentEstimate;
    
    euclid = euclidDistance(currentDevicePosition,currentEstimate);
    disp('Current point index:');
    disp(i);
    disp('Current approx distance:');
    disp(euclid);
    disp('');
    
    errors(i) = (totalDistance/radioRange)*100;
    totalDistance = totalDistance + euclid;
  end
  
  disp('Error:');
  disp(totalDistance*100/(numberOfPoints*radioRange));  
  
  visualize(gridPositions, estimates);
end

function [distances] = convertMeasurementsToDistances(rssiMeasurements)

  distances = zeros(length(rssiMeasurements),1);
  for i=1:length(rssiMeasurements)
    distances(i) = convertRssiToDistance(rssiMeasurements(i)) / 10;
  end
  
end

function [measurement] = takeSingleMeasurementColumn(measurements, index)
  measurement = measurements(:,index);
  measurement = [measurement(1:index-1);measurement(index+1:end)];
end

function [measurement] = takeSingleMeasurementRow(measurements, index)
  measurement = measurements(index,:);
  measurement = [measurement(1:index-1),measurement(index+1:end)];
end

function [gridPositionsFiltered] = filterGridPositions(gridPositions, index)
  gridPositionsFiltered = [gridPositions(:,1:index-1),gridPositions(:,index+1:end)];
end

function [distance] = euclidDistance(firstPoint,secondPoint)
  distance = sqrt(sum((firstPoint-secondPoint).^2));
end
