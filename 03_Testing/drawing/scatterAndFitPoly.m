function [] = scatterAndFitPoly( data )

  %scatter(data(1,:),data(2,:));
  
  
  [~,y] = size(data);  
  lowest = data(1,1);
  highest = data(1,y);
  newRange = lowest:(highest-lowest)/1000:highest;
  
  
  scatter(data(1,:),data(2,:),'+');
  p = polyfit(data(1,:),data(2,:),2);
  newValue = polyval(p,newRange);
  plot(newRange,newValue);
  
  
end




