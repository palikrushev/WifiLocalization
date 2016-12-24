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
  eachStepRunTimes = 100;
  
  fileID = fopen('TestResult.txt','w');
  fprintf(fileID,'GridPositionJitter %f\n',gridPositionJitter);
  fprintf(fileID,'PathNumberOfSplits %f\n',pathNumberOfSplits);
  fprintf(fileID,'NumberOfPointsToFilter %f\n',numberOfPointsToFilter);
  fprintf(fileID,'ErrorPercentageOfRange %f\n\n',errorPercentageOfRange);
  
  index = 1;
  
  while radioRange < 1.5001    % CARE SHOULD BE 1.0001
    disp(radioRange);
    
    [totalError,totalConnectivity] = runItNTimes(eachStepRunTimes,gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
   
    errors(:,index) = [radioRange, totalError];
    
    allRadioRange(index) = radioRange;
    allTotalError(index) = totalError;
    allTotalConnectivity(index) = totalConnectivity;
    fprintf(fileID,'RadioRange %f\n',radioRange);
    fprintf(fileID,'TotalError %f\n',totalError);   
    fprintf(fileID,'TotalConnectivity %f\n\n',totalConnectivity);   
    
    index = index + 1;
    radioRange = radioRange + radioRangeStep; 
  end
  plot(errors(1,:),errors(2,:));
  
  disp('results:');  
  printArrayToFileAndDisplay(fileID, 'RadioRanges', allRadioRange);
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
    	[error,connectivity] = integratedTestGeneratorWParamsConnectivity(gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
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

