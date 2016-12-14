function [outX, outY] = find_min_squared_center(inX, inY, inR)

n = length(inX);

% temporary and wrong way to select starting point
xc = 0;
yc = 0;
for ii = 1:n
    xc = xc + inX(ii);
    yc = yc + inY(ii);
end





end

