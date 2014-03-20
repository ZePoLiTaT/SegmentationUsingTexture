function [imlabels, lbl_stats] = explore_queue(im, imlabels, lbl_stats, threshold, r0, c0, region)
%EXPLORE_QUEUE_COLOR Expands a region of a N-D feature vector given a starting pixel.
%   The exploration is made using a queue using 8-neighborhood.
%   Every time a new pixel is added to the region is removed from the 
%   list of available random seeds to pick.

    [R,C,F] = size(im);
    
    region_labels = zeros(R,C);
    queue = zeros(R*C,2);
    
    queue(1,:) = [r0, c0];
    region_labels(r0,c0) = 1;
    
    %Initialize statistics
    lbl_stats(region).sum = zeros(1,F);
    lbl_stats(region).counter = 0;
    lbl_stats(region).mean = get_feature(im,r0,c0);
   
    ix_front = 1;
    ix_back = 2;

    while ( ix_front < ix_back )
        r = queue(ix_front,1);  c = queue(ix_front,2); 
        cell = get_feature(im,r,c);
        
        %euclidean distance
        euc_dst = norm(cell - lbl_stats(region).mean,2);
        
        %If the pixel is a neighboor and is within the threshold
        if( euc_dst < threshold)

            %Mark the pixel as within the region
            imlabels(r,c) = region;

            %Update mean of statistics [Sum, Counter, Avg]
            lbl_stats(region).sum = lbl_stats(region).sum + cell;
            lbl_stats(region).counter=  lbl_stats(region).counter + 1;
            lbl_stats(region).mean=  lbl_stats(region).sum ./ lbl_stats(region).counter;

            neighboors = get_neighborhood(r,c);  

            for i=1:length(neighboors)
                r = neighboors(i,1);  c = neighboors(i,2);

                if (r > 0 && r <= R && ...
                    c > 0 && c <= C && ...
                    imlabels(r,c) == 0 && ...
                    region_labels(r,c) == 0 )

                    region_labels(r,c) = 1;
                    queue(ix_back,:) = neighboors(i,:);
                    ix_back = ix_back + 1;
                end
            end
        end
        
        ix_front = ix_front + 1;
    end
    
end

function nbhood = get_neighborhood(r,c)
    %Add to the queue its neighboors
    nbhood = [r-1, c  ;  % up
              r-1, c+1;  % right up
              r  , c+1;  % right 
              r+1, c+1;  % right-down 
              r+1, c  ;  % down
              r+1, c-1;  % left-down
              r  , c-1;  % left
              r-1, c-1]; % left-up     
end

function featvec = get_feature(im, r, c)
    featvec = im(r,c,:);
    featvec = featvec(:)';
end