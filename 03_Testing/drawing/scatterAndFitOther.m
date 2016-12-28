function [] = scatterAndFitOther( data )

  %scatter(data(1,:),data(2,:),'+');
  
  [XOut,YOut] = prepareCurveData(data(1,:),data(2,:));
  
  options = fitoptions('Method','SmoothingSpline','SmoothingParam',0.9999);
  
  f=fit(XOut,YOut,'SmoothingSpline',options);
  plot(f,XOut,YOut);  
  
end





