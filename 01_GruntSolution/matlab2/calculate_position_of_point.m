% static_points is matrix [nStaticPoints,nDim]
% rss_to_point is column vector [nStaticPoints]
% radio_range is the max value for which rss will be considered
% min_number_of_points_to_consider is min number of points to be considered

% best_result is the row vector of the coordinates of the point [nDim]
function [ best_result ] = calculate_position_of_point( static_points, rss_to_point, radio_range, min_number_of_points_to_consider)

    [~,number_of_dimensions] = size(static_points);
    
    options = optimoptions(@fminunc,'Algorithm','quasi-newton','MaxFunEvals',1000,'Display','off');

    best_value = inf;
    best_result = zeros(1,number_of_dimensions);
    
    [filtered_static_points,filtered_rss_to_point] = filter_points_with_rss_above_threshold(static_points, rss_to_point, radio_range, min_number_of_points_to_consider); 
    
    for ii = 1:100
        starting_point = rand(1,number_of_dimensions);   
        
        result = fminsearch(@(point)squared_sum_of_distances_from_point_to_circles(point,filtered_static_points,filtered_rss_to_point),starting_point,options);
        value = squared_sum_of_distances_from_point_to_circles(result,filtered_static_points,filtered_rss_to_point);

        if (value < best_value)
            best_value = value;
            best_result = result;
        end

    end

end

