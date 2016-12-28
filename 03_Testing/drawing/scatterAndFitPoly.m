function [] = scatterAndFitPoly( data )

  %scatter(data(1,:),data(2,:));
  
%  figure;
%  hold on;
%  grid on;
  
  [~,y] = size(data);  
  lowest = data(1,1);
  highest = data(1,y);
  newRange = lowest:(highest-lowest)/1000:highest;
 % newRange = 0.3:0.001:0.5;
 % newRange = 10:0.01:35;
 
  scatter(data(1,:),data(2,:),'+');
  p = polyfit(data(1,:),data(2,:),2);
  newValue = polyval(p,newRange);
  plot(newRange,newValue);
  
  
end




