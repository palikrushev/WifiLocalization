function [ error ] = calculate_error( trajectory_points, estimated_trajectory_points )

    [number_of_points,~] = size(trajectory_points);
    
    sum_of_distances = 0;
    for ii = 1:number_of_points
        sum_of_distances = sum_of_distances + euclid_distance(trajectory_points(ii,:),estimated_trajectory_points(ii,:));
    end
    
    error = sum_of_distances / (number_of_points);

end

