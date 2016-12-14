function [ result ] = squared_sum_of_distances_from_point_to_circles( point, circle_centers, circle_radiuses )

    [number_of_circles,~] = size(circle_centers);
    result = 0;

    for ii = 1:number_of_circles
        center = circle_centers(ii,:);
        radius = circle_radiuses(ii,:);
       
        difference = (euclid_distance(point, center) - radius).^2;
        result = result + difference;
    end

end

