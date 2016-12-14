function [  ] = visualize( static_points, trajectory_points, estimated_trajectory_points )
    
    [nTrajectoryPoints, ~] = size(trajectory_points);
    
    figure;
    hold on;
    grid on;
    
    scatter3(static_points(:,1),static_points(:,2),static_points(:,3),'filled','Marker','o','MarkerEdgeColor','Blue');
    plot3(trajectory_points(:,1),trajectory_points(:,2),trajectory_points(:,3),'Marker','o','Color','Green');

    for ii = 1:nTrajectoryPoints
        plot3([trajectory_points(ii,1) estimated_trajectory_points(ii,1)],[trajectory_points(ii,2) estimated_trajectory_points(ii,2)],[trajectory_points(ii,3) estimated_trajectory_points(ii,3)],'Marker','*','Color','Red');
    end
    
    axis([0 1 0 1 0 1]);
    
    
    %text(-1.3,1,0.3,{sprintf('The error is %f',123), 'asdasd', 'asdasd', 'asdasd', 'asdasd'});
    
    view([1 -1 1]);

end

 