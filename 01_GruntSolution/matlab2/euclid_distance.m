function [ distance ] = euclid_distance( first_point, second_point )

    number_of_dimensions = length(first_point);
    sum_of_squared_differences = 0;
    
    for ii = 1:number_of_dimensions
        sum_of_squared_differences = sum_of_squared_differences + (first_point(ii)-second_point(ii)).^2;
    end

    distance = sqrt(sum_of_squared_differences);
    
end

