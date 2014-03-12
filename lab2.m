clear; clc; close all;

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



im_feli = imread('P2_seg/feli.tif');
im_feli = rgb2gray(im_feli);
comat_im_feli = graycomatrix(im_feli, 'Offset',[0 2], 'Symmetric', true);
stats_im_feli = graycoprops(comat_im_feli,{'Contrast','Homogeneity', 'Energy', 'Correlation'})


fun = @(x) graycomatrix(x, 'Offset',[0 1], 'Symmetric', true);
features = nlfilter(im_feli,[3 3],fun);

