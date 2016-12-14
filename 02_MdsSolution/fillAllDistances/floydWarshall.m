function [fullDistanceMatrix] = floydWarshall(distanceMatrix)

  % fills the INF distances with values, ONLY modifies INF distances
  % distanceMatrix: NxN square distance matrix

  N1 = length(distanceMatrix(:,1));
  N2 = length(distanceMatrix(1,:));

  if (N1 ~= N2)
    error('Matrix is not square');
  end

  N=N1;
  fullDistanceMatrix=distanceMatrix;

  for k=1:N
      for i=1:N
          for j=1:N
              if (distanceMatrix(i,j) == inf) && (fullDistanceMatrix(i,j) > fullDistanceMatrix(i,k) + fullDistanceMatrix(k,j))
                  fullDistanceMatrix(i,j) = fullDistanceMatrix(i,k) + fullDistanceMatrix(k,j);
              end
          end
      end
  end

end
