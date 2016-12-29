function [errors] = integratedTestRunnerRangeForConnectivity()

  % CARE TEMP FUNCTION
  % CARE TEMP FUNCTION
  % CARE TEMP FUNCTION

  gridPositionJitter = 0.2;  % Random grid
  pathNumberOfSplits = 5;    % 2^N+1 path points
  numberOfPointsToFilter = Inf; 
  radioRange = 0.1;           % CARE SMALL RADIO RANGE (should be 0.2)
  errorPercentageOfRange = 0; % CARE ZERO ERROR (should be 0.1)
  radioRangeStep = 0.01;
  eachStepRunTimes = 1000;
  
  fileID = fopen('TestResult.txt','w');
  fprintf(fileID,'GridPositionJitter %f\n',gridPositionJitter);
  fprintf(fileID,'PathNumberOfSplits %f\n',pathNumberOfSplits);
  fprintf(fileID,'NumberOfPointsToFilter %f\n',numberOfPointsToFilter);
  fprintf(fileID,'ErrorPercentageOfRange %f\n\n',errorPercentageOfRange);
  
  index = 1;
  
  while radioRange < 0.3501    % CARE SHOULD BE 1.0001
    disp(radioRange);
    
    [totalConnectivity, withNeighbors, withoutNeighbors] = runItNTimes(eachStepRunTimes,gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
       
    allRadioRange(index) = radioRange;
    allTotalConnectivity(index) = totalConnectivity;
    allWithNeighbors(index) = withNeighbors;
    allWithoutNeighbors(index) = withoutNeighbors;
    fprintf(fileID,'RadioRange %f\n',radioRange);
    fprintf(fileID,'TotalConnectivity %f\n\n',totalConnectivity);   
    
    index = index + 1;
    radioRange = radioRange + radioRangeStep; 
  end
  
  percentageWithoutNeighbors = allWithoutNeighbors ./ (allWithoutNeighbors + allWithNeighbors);
  
  plot(allRadioRange, percentageWithoutNeighbors);
  
  disp('results:');  
  printArrayToFileAndDisplay(fileID, 'RadioRanges', allRadioRange);
  printArrayToFileAndDisplay(fileID, 'TotalConnectivities', allTotalConnectivity);
  printArrayToFileAndDisplay(fileID, 'WithoutNeighbors', allWithoutNeighbors);
  printArrayToFileAndDisplay(fileID, 'WithNeighbors', allWithNeighbors);
  printArrayToFileAndDisplay(fileID, 'PercentageWithoutNeighbors', percentageWithoutNeighbors);
  
  fclose(fileID);
end

function [totalConnectivity, withNeighbors, withoutNeighbors] = runItNTimes(N,gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange)

  timesRan = 0;
  connectivitySum = 0;
  withNeighbors = 0;
  withoutNeighbors = 0;
  while timesRan < N

    try
    	[connectivity, numberOfPointsWithNeighbor, numberOfPointsWithoutNeighbor] = integratedTestGeneratorWParamsConnectivity(gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
    catch exception
      disp('retry');
      continue;
    end
    
    withNeighbors = withNeighbors + numberOfPointsWithNeighbor;
    withoutNeighbors = withoutNeighbors + numberOfPointsWithoutNeighbor;
    connectivitySum = connectivitySum + connectivity;
    timesRan = timesRan + 1;
  end
  
  totalConnectivity = connectivitySum / N;  
end

function [] = printArrayToFileAndDisplay(fileID, stringName, array)
  line = strrep([stringName ': [' sprintf('%d;', array) ']'], ';]', ']');
  fprintf(fileID,'%s\n',line);
  disp(line);
end


