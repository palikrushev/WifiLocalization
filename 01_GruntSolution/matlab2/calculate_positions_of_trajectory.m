% static_points is matrix [nStaticPoints,nDim]
% rss_to_point is matrix [nTrajectoryPoints, nStaticPoints]
% radio_range is the max value for which rss will be considered
% min_number_of_points_to_consider is min number of points to be considered

% result is the matrix of the coordinates of the trajectory points
% [nTrajectoryPoints,Dim]
function [ result ] = calculate_positions_of_trajectory( static_points, rss_to_points, radio_range, min_number_of_points_to_consider)

    [~,nDim] = size(static_points);
    [nTrajectoryPoints,~] = size(rss_to_points);
    result = zeros(nTrajectoryPoints,nDim);
    
    for ii = 1:nTrajectoryPoints
        
        rss_to_point_transposed = rss_to_points(ii,:)';
        
        fprintf('Calculating trajectory point %i/%i\n',ii,nTrajectoryPoints);
        point_result = calculate_position_of_point( static_points, rss_to_point_transposed, radio_range, min_number_of_points_to_consider);
        
        result(ii,:) = point_result;
    end
end

