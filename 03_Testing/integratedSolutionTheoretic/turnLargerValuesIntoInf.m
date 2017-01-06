function [ listOfModifiedValues ] = turnLargerValuesIntoInf(listOfValues, determinantValue)

  listOfModifiedValues = listOfValues;
  
  for j=1:length(listOfValues)
    if (listOfValues(j) > determinantValue)
      listOfModifiedValues(j) = inf;
    end
  end
end

