function [] = visualize(gridPositions, estimates)

  gridPositions = gridPositions * 10;
  estimates = estimates * 10;

  figure;
  hold on;
  grid on;
  
  zeroToOne = true;
  
  if (zeroToOne)
    axis([0 9 0 8]);
    
    axes = gca;
    axes.XTick = 0:1:9;
    axes.YTick = 0:1:8;

    xlabel('X');
    ylabel('Y');
  end

  scatter(gridPositions(1,:),gridPositions(2,:),50,'Marker','o','MarkerEdgeColor','blue');
  scatter(estimates(1,:),estimates(2,:),50,'Marker','x','MarkerEdgeColor',[0.1 0.4 0.1]);
  
  [~,numberOfPoints] = size(estimates);
  for i = 1:numberOfPoints
  	plot([gridPositions(1,i) estimates(1,i)],[gridPositions(2,i) estimates(2,i)],'Color','red','LineWidth',2);
  end  

end

