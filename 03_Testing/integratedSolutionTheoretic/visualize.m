function [] = visualize(pathPositions, pathPositionEstimates)

  [~,numberOfPathPoints] = size(pathPositions);
  
  figure;
  hold on;
  grid on;
  
  scatter3(pathPositions(1,:),pathPositions(2,:),pathPositions(3,:),'filled','Marker','o','MarkerEdgeColor','Blue');
  plot3(pathPositionEstimates(1,:),pathPositionEstimates(2,:),pathPositionEstimates(3,:),'Marker','x','Color','Green');

  for i = 1:numberOfPathPoints
  	plot3([pathPositions(1,i) pathPositionEstimates(1,i)],[pathPositions(2,i) pathPositionEstimates(2,i)],[pathPositions(3,i) pathPositionEstimates(3,i)],'Marker','*','Color','Red');
  end
  
end

