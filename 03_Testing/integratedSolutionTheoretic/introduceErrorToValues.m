function [ result ] = introduceErrorToValues( columnVectorOfValues, maximalError, minValue, maxValue )

  % Adds a uniform error to the values upto maximalError
  % The resulting value must be limited to minValue and maxValue
  
  result = columnVectorOfValues;
  
  for i=1:length(columnVectorOfValues)
    result(i,1) = (rand-0.5) * 2 * maximalError + columnVectorOfValues(i,1);
    result(i,1) = min(result(i,1), maxValue);
    result(i,1) = max(result(i,1), minValue);
  end  
end