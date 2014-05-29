function [ features, fSize ] = texture_features_local( imgray, wsize, d, numlvl )
% TEXTURE_FEATURES_LOCAL Computes a feature vector per pixel composed by the
% texture features given by the statistics of the co-occurrence matrix

    if (size(imgray,3) > 1)
        imgray = rgb2gray(imgray);
    end

    wsize_2 = floor(wsize/2);
    imgray = padarray(imgray,[wsize_2 wsize_2]);
    
    [R,C,~] = size( imgray );
    
    pad_r = wsize_2+1 : R - wsize_2;
    fSize(1) = length(pad_r);
    
    pad_c = wsize_2+1 : C - wsize_2;
    fSize(2) = length(pad_c);
    
    fSize(3) = 3*size(d,1);
    
    %The resulting feature matrix will have 3 x (dir,ang) channels:
    %   1. Contrast
    %   2. Homogen  eity
    %   3. Energy
    features = zeros( fSize(1), fSize(2) , fSize(3) );
    
    for i = pad_r
        for j = pad_c
        
            submat = imgray(i-wsize_2:i+wsize_2, j-wsize_2:j+wsize_2);
            
            comat_submat = graycomatrix(submat, 'Offset',d, 'NumLevels',numlvl, 'Symmetric', true );
            stats_submat = graycoprops(comat_submat,{'Contrast','Homogeneity','Energy'});
            
            for k=0: size(d,1)-1
                features(i-wsize_2,j-wsize_2,1 + 3*k) = stats_submat.Contrast(k+1);      %Contrast
                features(i-wsize_2,j-wsize_2,2 + 3*k) = stats_submat.Homogeneity(k+1);   %Homogeneity
                features(i-wsize_2,j-wsize_2,3 + 3*k) = stats_submat.Energy(k+1);        %Energy
            end
        end
    end
end
