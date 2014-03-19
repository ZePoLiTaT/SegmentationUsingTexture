 function lab2

    clear; clc; close all;

    %test_segmentation_toy
    %test_segmentation;
    
    test_classification;

 end

 function test_segmentation_toy
    % Toy image:
%    im = zeros(5,4,3);
%     im(:,:,1) = [ 50 45 100 101;
%                   49 48 105 104;
%                   200 47 2 3;
%                   100 5 1 4;
%                   101 102 10 300];
%               
%     im(:,:,2) = [ 50 45 100 101;
%                   49 48 105 104;
%                   200 47 2 3;
%                   100 5 1 4;
%                   101 102 10 300];
%               
%     im(:,:,3) = [ 50 45 100 101;
%                   49 48 105 104;
%                   200 47 2 3;
%                   100 5 1 4;
%                   101 102 10 300];
              
    %Homogeneous image
    im = ones(6,7,3);
    im(4:6,:,:) = 120

    tic
    toy_features = texture_features_local(im, 3, 0, 1);
    toc
 end
 
 function test_segmentation
 
    im_feli = imread('P2_seg/feli.tif');
    im_feli_gray = rgb2gray( im_feli );
    
    tic
    im_feli_features = texture_features_local(im_feli, 11, 0,4);
    toc
    %features = nlfilter(im_feli_gray,[11 11],@get_texture_features);
    
    threshold = 10;
    
    % Region growing for color images without filter
    [imlabels, lbl_stats] = region_growing(im_feli_features, threshold);
    
 end
 
 function test_classification()
    im_feli = imread('P2_seg/feli.tif');
    im_feli = rgb2gray(im_feli);
    comat_im_feli = graycomatrix(im_feli, 'Offset',[0 2], 'Symmetric', true);
    stats_im_feli = graycoprops(comat_im_feli,{'Contrast','Homogeneity', 'Energy', 'Correlation'})
 end
 
 function test_comatrices()
    a =[0 2 0 2 0
        0 2 0 2 0
        0 2 0 2 0
        1 1 1 3 1
        1 1 1 3 1];

    b =[2 2 2 2 2
        2 2 2 2 2
        2 2 2 2 2
        1 1 1 1 1
        1 1 1 1 1];

    comat_a = graycomatrix(a, 'Offset',[0 1], 'NumLevels',4, 'GrayLimits', [0 3], 'Symmetric', true)
    comat_b = graycomatrix(b, 'Offset',[0 1], 'NumLevels',4, 'GrayLimits', [0 3], 'Symmetric', true)


    stats_a = graycoprops(comat_a,{'Contrast','Homogeneity', 'Energy', 'Correlation'})
    stats_b = graycoprops(comat_b,{'Contrast','Homogeneity', 'Energy', 'Correlation'})

 end
 
function stats_x = get_texture_features(x)
    comat_x = graycomatrix(x, 'Offset',[0 1], 'Symmetric', true);
    stats_x = graycoprops(comat_x,{'Contrast'});
    stats_x = stats_x.Contrast;
end