function [errors] = integratedTestRunnerRange()

  gridPositionJitter = 0.2;  % Random grid
  pathNumberOfSplits = 5;    % 2^N+1 path points
  numberOfPointsToFilter = 10;
  radioRange = 0.2;
  errorPercentageOfRange = 0.1;
  
  fileID = fopen('TestResult.txt','w');
  fprintf(fileID,'GridPositionJitter %f\n',gridPositionJitter);
  fprintf(fileID,'PathNumberOfSplits %f\n',pathNumberOfSplits);
  fprintf(fileID,'NumberOfPointsToFilter %f\n',numberOfPointsToFilter);
  fprintf(fileID,'ErrorPercentageOfRange %f\n\n',errorPercentageOfRange);
  
  index = 1;
  
  while radioRange < 1.01
    disp(radioRange);
    totalError = integratedTestGeneratorWParams(gridPositionJitter,pathNumberOfSplits,numberOfPointsToFilter,radioRange,errorPercentageOfRange);
    errors(:,index) = [radioRange, totalError];
    index = index + 1;
    radioRange = radioRange + 0.01;
    
    fprintf(fileID,'RadioRange %f\n\n',radioRange);
    fprintf(fileID,'TotalError %f\n\n',totalError);    
  end
  fclose(fileID);
  plot(errors(1,:),errors(2,:));
end

