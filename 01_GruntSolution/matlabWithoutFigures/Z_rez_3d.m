function [ outPoints, totalError ] = Z_rez_3d( inX, inY, inZ, inR, points )

    [nPoints,~] = size(inR);
    
    outPoints = zeros(nPoints,3);
    
    totalError = 0;
    
    options = optimoptions(@fminunc,'Algorithm','quasi-newton','MaxFunEvals',1000);
    
    for ii = 1:nPoints
        
        bestValue = inf;
        bestRez = [0,0,0];
        currentR = inR(ii,:);
        
        for jj = 1:100
            x0 = [rand(),rand(),rand()];
            rez = fminsearch(@(x)X_optimize_3d(x,inX,inY,inZ,currentR),x0,options);
            value = X_optimize_3d(rez,inX,inY,inZ,currentR);
            
            if (value < bestValue)
                bestValue = value;
                bestRez = rez;
            end
            
        end
        
        outPoints(ii,1) = bestRez(1);
        outPoints(ii,2) = bestRez(2);
        outPoints(ii,3) = bestRez(3);
        
        totalError = totalError + two_point_distance(points(ii,1),points(ii,2),points(ii,3),outPoints(ii,1),outPoints(ii,2),outPoints(ii,3));
    end
    
    totalError = totalError / (nPoints * 1.7321);
    
end

