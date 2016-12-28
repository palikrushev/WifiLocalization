function [gridPositions] = generateGrid(positionJitter)

% Creates 125 points
    % for GRID setup use positionJitter = 0.05;
    % for RANDOM setup use positionJitter = 0.2;
    
  if(~exist('positionJitter','var'))
    positionJitter = 0.2;
  end

  step = [0.2;0.2;0.2];
  start = [0.1;0.1;0.1];
  final = [0.9;0.9;0.9];
    
  count = 1;
  gridPositions = zeros(3,125);

  i = start(1);
  while i <= final(1)
    
    j = start(2);
    while j <= final(2)
      
      k = start(3);
      while k <= final(3)
        
        % DO stuff
        x = (rand-0.5)*positionJitter + i;
        y = (rand-0.5)*positionJitter + j;
        z = (rand-0.5)*positionJitter + k;
        
        gridPositions(1,count) = x;
        gridPositions(2,count) = y;
        gridPositions(3,count) = z;
        
        count = count + 1;
        %%%%%%%%%%%%
        
        k = k + step(3);
      end
      
      j = j + step(2);
    end
    
    i = i + step(1);
  end
end

