% for no filtering use: threshold=inf, min_number_of_points_to_consider=0
% rss_to_point is column vector
function [ filtered_points, filtered_rss ] = filter_points_with_rss_above_threshold( static_points, rss_to_point, threshold, min_number_of_points_to_consider )
    
    [number_of_points,number_of_dimensions] = size(static_points);
    
    % placing the rss to the points as another dimension according to which
    % the points will be sorted
    combined_points = [static_points rss_to_point];
    sorted_combined_points = sortrows(combined_points, number_of_dimensions+1);
    
    % find the position where the rss becomes larger than threshold
    number_of_filtered_points = number_of_points;
    for ii = 1:number_of_points
        if (sorted_combined_points(ii,number_of_dimensions+1)>threshold)
            number_of_filtered_points = ii-1;
            break
        end
    end
    
    number_of_points_to_filter = max(min_number_of_points_to_consider, number_of_filtered_points);
    number_of_points_to_filter = min(number_of_points_to_filter, number_of_points);
    
    % cropping the points
    filtered_combined_points=sorted_combined_points(1:number_of_points_to_filter,:);
    
    % preparing result
    filtered_points=filtered_combined_points(:,1:number_of_dimensions);
    filtered_rss=filtered_combined_points(:,number_of_dimensions+1);
    
end

