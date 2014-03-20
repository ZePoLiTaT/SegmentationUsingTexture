function [ imlabels, lbl_stats ] = region_growing( im, threshold )
%REGION_GROWING Returns a segmented image with an N-D feature
%   vector starting with a seed
%   placed in the upper left corner using a queue and an array 
%   with the statistics of each one (sum of the values in the region, 
%   total number of pixels in the region and its mean)

    [R,C,F] = size(im);
    
    lbl_stats(R*C).sum = zeros(1,F);
    lbl_stats(R*C).counter = 0;
    lbl_stats(R*C).mean = zeros(1,F);

    imlabels = zeros(R,C);
    number_regions = 0;

    for r = 1:R
        for c = 1:C
            %Whenever we find a new region, expand it
            if imlabels(r,c) == 0
                
                %Increase the number of regions
                number_regions = number_regions + 1;
                
                %Mark pixel as labeled
                imlabels(r,c) = number_regions;
                
                %Explore region
                [imlabels, lbl_stats] = explore_queue(  double(im),... 
                                                        imlabels, ...
                                                        lbl_stats, ...
                                                        threshold, ...
                                                        r, c, ...
                                                        number_regions);
            end
        end
    end
    
    
end