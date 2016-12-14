function [ error ] = combined()

    static_points = [0.2 0.7 0.4;
                    0.2 0.3 0.6;
                    0.4 0.7 0.6;
                    0.4 0.3 0.4;
                    0.6 0.7 0.4;
                    0.6 0.3 0.6;
                    0.8 0.7 0.6;
                    0.8 0.3 0.4];

    trajectory_points = [0.0 0.5 0.5;
                        0.1 0.5 0.5;
                        0.2 0.5 0.5;
                        0.3 0.5 0.5;
                        0.4 0.5 0.5;
                        0.5 0.5 0.5;
                        0.6 0.5 0.5;
                        0.7 0.5 0.5;
                        0.8 0.5 0.5;
                        0.9 0.5 0.5;
                        1.0 0.5 0.5];            
    
    radio_range = inf;
    min_points_to_consider = inf;
    std_dev = 0.05;
    
    
    rss_to_points = calculate_rss(static_points,trajectory_points);
    rss_to_points_with_noise = add_gaussian_white_noise(rss_to_points,std_dev);
    
    estimated_trajectory_points = calculate_positions_of_trajectory(static_points, rss_to_points_with_noise, radio_range, min_points_to_consider);
    
    error = calculate_error(trajectory_points, estimated_trajectory_points);
    
    visualize(static_points, trajectory_points, estimated_trajectory_points); 
    %text must be after visualize
    text(-1.3,1,0.3,{sprintf('Error: %g',error), sprintf('Radio range: %g',radio_range), sprintf('Min points to consider: %g',min_points_to_consider), sprintf('Standard deviation: %g',std_dev)});
    
end

