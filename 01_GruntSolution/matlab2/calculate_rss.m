% static_points [nStaticPoints,nDim]
% trajectory_points [nTrajectoryPoints,nDim]

% rss_to_points [nTrajectoryPoints,nStaticPoints]
function [ rss_to_points ] = calculate_rss( static_points, trajectory_points )

    [nStaticPoints,~] = size(static_points);
    [nTrajectoryPoints,~] = size(trajectory_points);

    rss_to_points = zeros(nTrajectoryPoints,nStaticPoints);
    
    for ii = 1:nTrajectoryPoints        
        trajectory_point = trajectory_points(ii,:);        
        for jj = 1:nStaticPoints            
            static_point = static_points(jj,:);            
            distance = euclid_distance(trajectory_point, static_point);            
            rss_to_points(ii,jj) = distance;            
        end
    end
end

