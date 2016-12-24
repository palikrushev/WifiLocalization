function [] = visualizeGridPathAndEstimate(gridPositions, pathPositions, pathPositionEstimates)

  figure;
  hold on;
  grid on;
  axis([-0.1 1.1 -0.1 1.1 -0.1 1.1]);
  
  axes = gca;
  axes.XTick = -0.1:0.1:1.1;
  axes.YTick = -0.1:0.1:1.1;
  axes.ZTick = -0.1:0.1:1.1;
  
  xlabel('X');
  ylabel('Y');
  zlabel('Z');
  
  scatter3(gridPositions(1,:),gridPositions(2,:),gridPositions(3,:),'Marker','.','MarkerEdgeColor',[0.5 0.5 1]);
  
  scatter3(pathPositions(1,:),pathPositions(2,:),pathPositions(3,:),30,'Marker','o','MarkerEdgeColor','blue');
  fnplt(cscvn(pathPositions(:,1:end)),'blue',1);
  
  scatter3(pathPositionEstimates(1,:),pathPositionEstimates(2,:),pathPositionEstimates(3,:),30,'Marker','x','MarkerEdgeColor',[0.1 0.4 0.1]);
  
  
  [~,numberOfPoints] = size(pathPositionEstimates);
  for i = 1:numberOfPoints
  	plot3([pathPositions(1,i) pathPositionEstimates(1,i)],[pathPositions(2,i) pathPositionEstimates(2,i)],[pathPositions(3,i) pathPositionEstimates(3,i)],'Color','red','LineWidth',2);
  end
  
  
end

