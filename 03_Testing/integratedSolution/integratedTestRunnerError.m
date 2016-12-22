function [] = integratedTestRunnerError()

  gridPositionJitter = 0.2;  % Random grid
  pathNumberOfSplits = 5;    % 2^N+1 path points
  numberOfPointsToFilter = 10;
  radioRange = 0.5;
  errorPercentageOfRange = 0;
  
  fileID = fopen('TestResult.txt','w');
  fprintf(fileID,'GridPositionJitter %f\n',gridPositionJitter);
  fprintf(fileID,'PathNumberOfSplits %f\n',pathNumberOfSplits);
  fprintf(fileID,'NumberOfPointsToFilter %f\n',numberOfPointsToFilter);
  fprintf(fileID,'RadioRange %f\n\n',radioRange);
  
  index = 1;
  
  while errorPercentageOfRange <= 0.3
    disp(errorPercentageOfRange);
    try
    	[totalError,totalConnectivity] = integratedTestGeneratorWParams(gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
    catch exception
      disp('retry');
      continue;
    end
    errors(:,index) = [errorPercentageOfRange, totalError];
    index = index + 1;
    
    fprintf(fileID,'ErrorPercentageOfRange %f\n',errorPercentageOfRange);
    fprintf(fileID,'TotalError %f\n\n',totalError);    
    
    errorPercentageOfRange = errorPercentageOfRange + 0.01;
  end
  fclose(fileID);
  plot(errors(1,:),errors(2,:));
end

