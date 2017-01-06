function [ result ] = sortByRange( params )

  [rows,~] = size(params);
  
  resultValue = 0;
  resultRow = 0;
  resultIndex = 0;
  
  for i= 1:rows
    currentRow = params(i,:);
    currentRowSize = length(currentRow);
    
    if (resultValue ~= currentRow(1))
      resultValue = currentRow(1);
      resultRow = resultRow + 1;
      result(resultRow, 1) = resultValue;
      resultIndex = 2;
    end
    for j = 2:currentRowSize
      result(resultRow,resultIndex) = currentRow(j);
      resultIndex = resultIndex + 1;
    end
  end


end

