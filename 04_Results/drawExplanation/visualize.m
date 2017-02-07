function [] = visualize(points, startPoint, endPoint)

  figure;
  hold on;
  grid on;
  axis([startPoint endPoint startPoint endPoint startPoint endPoint]);
  
  axes = gca;
  axes.XTick = startPoint:0.2:endPoint;
  axes.YTick = startPoint:0.2:endPoint;
  axes.ZTick = startPoint:0.2:endPoint;
  
  xlabel('X');
  ylabel('Y');
  zlabel('Z');
  
  scatter(points(1,:),points(2,:),'Marker','o','MarkerEdgeColor',[0.3 0.3 1], 'MarkerFaceColor',[0.3 0.3 1]);
  
  [~,length] = size(points);
  
  for i=1:length
    text(points(1,i),points(2,i), sprintf('P%d',i), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 20);
  end
  
  
end

