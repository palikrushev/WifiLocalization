function [result] = convertPoisson(array)

  result = zeros(sum(array),1);

  index = 1;
  for i=1:length(array)
    for j=1:array(i)
      result(index) = i-1;
      index = index + 1;
    end
  end

end

