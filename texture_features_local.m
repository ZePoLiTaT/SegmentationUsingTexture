function [ features ] = texture_features_local( im, wsize, theta, d )
% TEXTURE_FEATURES_LOCAL Computes a feature vector per pixel composed by the
%texture features given by the statistics of the 
%   Detailed explanation goes here

    imgray = rgb2gray(im);

    [R,C,~] = size( im );
    wsize_2 = floor(wsize/2);
    
    pad_r = wsize_2+1 : R - wsize_2;
    pad_c = wsize_2+1 : C - wsize_2;
    
    %The resulting feature matrix will have 7 channels:
    %   1. Contrast
    %   2. Homogen  eity
    %   3. Energy
    %   4. Correlation
    %   5. R channel
    %   6. G channel
    %   7. B channel
    features = zeros(R,C, 5);
    
    for i = pad_r
        for j = pad_c
            submat = imgray(i-wsize_2:i+wsize_2, j-wsize_2:j+wsize_2, :);
            
            comat_submat = graycomatrix(submat, 'Offset',[theta d], 'Symmetric', true);
            stats_submat = graycoprops(comat_submat,{'Contrast','Homogeneity', 'Energy', 'Correlation'});
            
            features(i,j,1) = stats_submat.Contrast;      %Contrast
            features(i,j,2) = stats_submat.Homogeneity;   %Homogeneity
            %features(i,j,3) = stats_submat.Energy;        %Energy
            %features(i,j,4) = stats_submat.Correlation;   %Correlation
            features(i,j,3) = im(i,j,1);                  %R
            features(i,j,4) = im(i,j,2);                  %G
            features(i,j,5) = im(i,j,3);                  %B 
        end
    end
        
    %Normalize at the end!!
    features(pad_r, pad_c, :) = normalize_features( features(pad_r, pad_c, :) )
    
end

function norm_features = normalize_features( features )
%% NORM_FEATURES Normalizes the feature matrix 
%   NORM_FEATURES(features) returns a normalized version of the features
%   where the mean value of each feature is 0 and the standard deviation is
%   one.

    [R,C,F] = size(features);
    features2D = double( unfold_matrix( features ) );
    
    mean_f = mean(features2D);
    norm_features = bsxfun( @minus, features2D, mean_f );
    
    std_f = std(features2D);
    norm_features = bsxfun( @rdivide, norm_features, std_f );
    
    norm_features = fold_matrix(norm_features,R,C,F);
end

function mat2D = unfold_matrix(mat3D)

    [R,C,F] = size(mat3D);
    mat2D = reshape( mat3D, C*R, F );
end

function mat3D = fold_matrix(mat2D,R,C,F)
    mat3D = reshape( mat2D, R, C, F );
end