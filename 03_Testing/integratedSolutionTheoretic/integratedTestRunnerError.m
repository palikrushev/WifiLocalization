function [errors] = integratedTestRunnerError()

  gridPositionJitter = 0.2;  % Random grid
  pathNumberOfSplits = 5;    % 2^N+1 path points
  numberOfPointsToFilter = 10;
  radioRange = 0.25;
  errorPercentageOfRange = 0;
  errorPercentageOfRangeStep = 0.01;
  eachStepRunTimes = 10;
  
  fileID = fopen('TestResult.txt','w');
  fprintf(fileID,'GridPositionJitter %f\n',gridPositionJitter);
  fprintf(fileID,'PathNumberOfSplits %f\n',pathNumberOfSplits);
  fprintf(fileID,'NumberOfPointsToFilter %f\n',numberOfPointsToFilter);
  fprintf(fileID,'RadioRange %f\n\n',radioRange);
  
  index = 1;
  
  while errorPercentageOfRange < 0.5001
    disp(errorPercentageOfRange);
    
    [totalError,totalConnectivity] = runItNTimes(eachStepRunTimes,gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
   
    errors(:,index) = [errorPercentageOfRange, totalError];
    
    allErrorPercentageOfRange(index) = errorPercentageOfRange;
    allTotalError(index) = totalError;
    allTotalConnectivity(index) = totalConnectivity;
    fprintf(fileID,'ErrorPercentageOfRange %f\n',errorPercentageOfRange);
    fprintf(fileID,'TotalError %f\n',totalError);    
    fprintf(fileID,'TotalConnectivity %f\n\n',totalConnectivity);   
    
    index = index + 1;
    errorPercentageOfRange = errorPercentageOfRange + errorPercentageOfRangeStep;
  end
  plot(errors(1,:),errors(2,:));
  
  disp('results:');  
  printArrayToFileAndDisplay(fileID, 'ErrorsAsPercentageOfRange', allErrorPercentageOfRange);
  printArrayToFileAndDisplay(fileID, 'TotalErrors', allTotalError);
  printArrayToFileAndDisplay(fileID, 'TotalConnectivities', allTotalConnectivity);
  
  fclose(fileID);
end

function [totalError,totalConnectivity] = runItNTimes(N,gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange)

  timesRan = 0;
  errorSum = 0;
  connectivitySum = 0;
  while timesRan < N

    try
    	[error,connectivity] = integratedTestGeneratorWParams(gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
    catch exception
      disp('retry');
      continue;
    end
    
    errorSum = errorSum + error;
    connectivitySum = connectivitySum + connectivity;
    timesRan = timesRan + 1;
  end
  
  totalError = errorSum / N;
  totalConnectivity = connectivitySum / N;  
end

function [] = printArrayToFileAndDisplay(fileID, stringName, array)
  line = strrep([stringName ': [' sprintf('%d;', array) ']'], ';]', ']');
  fprintf(fileID,'%s\n',line);
  disp(line);
end
