function [] = integratedTestGeneratorExperimental(gridPositions, measurements)

  [dimension,numberOfPoints] = size(gridPositions);
  
  distances = calculateAllDistances(gridPositions);
  estimatedDistances = zeros(numberOfPoints,1);
  errors = zeros(numberOfPoints,1);
  
  estimates = zeros(dimension,numberOfPoints);
  radioRange = max(distances);
  
  for i = 1:numberOfPoints
    
    currentDevicePosition = gridPositions(:,i);
    currentDeviceRssiMeasurements = takeSingleMeasurementColumn(measurements,i);
    currentDeviceDistanceMeasurements = convertMeasurementsToDistances(currentDeviceRssiMeasurements);
    
    filteredGridPositions = filterGridPositions(gridPositions,i);
    
    currentEstimate = integratedMdsMap(filteredGridPositions, currentDeviceDistanceMeasurements);
    estimates(:,i) = currentEstimate;
    estimagedDistance = euclidDistance(currentDevicePosition,currentEstimate);
    estimatedDistances(i) = estimagedDistance;
    
    errors(i) = (estimagedDistance/radioRange)*100;
  end
  
  distances = distances * 10;
  estimatedDistances = estimatedDistances * 10;
  radioRange = radioRange * 10;
  
  fileID = fopen('Test_5_Measurement_2.txt','w');
  
  printValueToFileAndDisplay(fileID,'Radio Range',radioRange);
  printValueToFileAndDisplay(fileID,'Infinite Values',sum(measurements(:) == -Inf));
  printArrayToFileAndDisplay(fileID,'Distances',distances);
  printArrayToFileAndDisplay(fileID,'Estimated Distances',estimatedDistances);
  printArrayToFileAndDisplay(fileID,'Errors',errors);
  
  printLineToFileAndDisplay(fileID,'\nProperties:');
  
  printPropertiesToFileAndDisplay(fileID, 'Distance', distances);
  printPropertiesToFileAndDisplay(fileID, 'Estimated Distance', estimatedDistances);
  printPropertiesToFileAndDisplay(fileID, 'Error', errors);
    
  fclose(fileID);
  
  visualize(gridPositions, estimates);
end

function [] = printPropertiesToFileAndDisplay(fileID, property, values)
  printLineToFileAndDisplay(fileID,sprintf('\n%s:',property));
  printValueToFileAndDisplay(fileID,'Mean',mean(values));
  printValueToFileAndDisplay(fileID,'Variance',var(values,1));
  printValueToFileAndDisplay(fileID,'Min',min(values));
  printValueToFileAndDisplay(fileID,'Max',max(values));
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

function [] = printArrayToFileAndDisplay(fileID, stringName, array)
  line = strrep([stringName ': [' sprintf('%d;', array) ']'], ';]', ']');
  fprintf(fileID,'%s\n',line);
  disp(line);
end

function [] = printValueToFileAndDisplay(fileID, stringName, value)
  line = [stringName ': ' sprintf('%.2f', value)];
  fprintf(fileID,'%s\n',line);
  disp(line);
end

function [] = printLineToFileAndDisplay(fileID, line)
  fprintf(fileID,line);
  disp(line);
end
