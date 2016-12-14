% arguments: rss_to_points, std_dev(optional)
%
% adds random noise from the distribution N(0,std_dev)
% sqrt(variance) = standard deviation
% recommended value for the dataset 0.025
% another method could be awgn
function [ result ] = add_gaussian_white_noise( varargin )
    
    narginchk(1,2);

    rss_to_points = varargin{1};
    [nTrajectoryPoints,nStaticPoints] = size(rss_to_points);
    
    if (nargin < 2)
        std_dev = std(rss_to_points(:));
    else
        std_dev = varargin{2};
    end
    
    result = rss_to_points + randn([nTrajectoryPoints,nStaticPoints])*std_dev;
    
   
    %values cant be less than zero
    for ii = 1:nTrajectoryPoints
        for jj = 1:nStaticPoints
            if (result(ii,jj) < 0)
                error('Less than zero [%s].',result(ii,jj));
            end
        end
    end
    
    
end