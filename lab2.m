 function lab2

    clear; clc; close all;

    %Test 1: Felino
    %test_segmentation_feli;
    
    %Test 2: Hand
    %test_segmentation_hand;
    
    %Test 3: Ping Pong
    %test_segmentation_ping_pong;
    
    %Test 4: Mosaic
    test_segmentation_mosaic;
    
 end
 
 %% Test 1: Felino
 % 
 function test_segmentation_feli
    
    im = imread('P2_seg/feli.tif');
    w = 30; d = 3;
    vd = [0 d];
    
    w = 13;
    vd = [-3 2]; %; -2 -3; -2 2; -2 -2; -1 1; -1 -1];
    %vd = [-3 2; -2 -3; -2 2; -2 -2; -1 1; -1 -1];
    %load('mosaic_d11.mat');
    
    %Extract Features
    im_features = generate_segmentation_data(im, w, vd, 8);
    
    %Normalize them
    [R,C,F] = size(im_features);
    text_features = reshape(im_features, R*C, F);
    text_features = normalize_features( text_features );
    im_features = reshape(text_features, R, C, F);
    
    figure;
    subplot(1,2,1), region_growing_caller(im, 40);
    subplot(1,2,2), region_growing_caller(im_features, 5.8);
 end
 
 %% Test 2: Hand
 % 
 function test_segmentation_hand
    
    im = imread('P2_seg/hand2.tif');
    
    % Test 1
    %w = 13; d = 3;
    %vd = [0 1; -1 0; -1 -1; 1 1];

    % Test 2
    %w = 3; d = 1;
    %vd = [0 d; d d];
    
    % Test 3
    w = 15; d = 1;
    vd = [0 d; -d d; -d 0; -d -d];
    
    %load('mosaic_d11.mat');
    
    %Extract Features
    im_features = generate_segmentation_data(im, w, vd, 8);
    
    %Normalize them
    [R,C,F] = size(im_features);
    text_features = reshape(im_features, R*C, F);
    text_features = normalize_features( text_features );
    im_features = reshape(text_features, R, C, F);
    
    figure;
    subplot(1,2,1), region_growing_caller(im, 65);
    
    %subplot(1,2,2), region_growing_caller(im_features, 5.8);
    %subplot(1,2,2), region_growing_caller(im_features(:,:,end-5:end), 2.566);
    
    %Test 3
    subplot(1,2,2), region_growing_caller(im_features(:,:,end-5:end), 2.8015);
 end

%% Test 3: Ping Pong
% 
function test_segmentation_ping_pong
    
    im = imread('P2_seg/pingpong2.tif');
    
    % Test 1
    %w = 9; d = 1;
    %vd = [0 d; -d d; -d 0; -d -d];
    %nlvl = 8;
    
    % Test 2
    %w = 3; d = 1;
    %vd = [0 d; -d d; -d 0; -d -d];
    %nlvl = 8;
    
    %Test 3
    w = 30; d = 3;
    vd = [0 d; -d d; -d 0; -d -d];
    nlvl = 6;
    
    %load('mosaic_d11.mat');
    
    %Extract Features
    im_features = generate_segmentation_data(im, w, vd, nlvl);
    
    %Normalize them
    [R,C,F] = size(im_features);
    text_features = reshape(im_features, R*C, F);
    text_features = normalize_features( text_features );
    im_features = reshape(text_features, R, C, F);
    
    figure;
    subplot(1,2,1), region_growing_caller(im, 65);
    
    %Test 1
    %hfe = im_features(:,:,7:9);
    %hfe(:,:,4:6) = im_features(:,:,end-2:end);
    %subplot(1,2,2), region_growing_caller(hfe, 2.259)
    
    %Test 2
    subplot(1,2,2), region_growing_caller(im_features, 4.17);
end 
 
%% Test 4: Mosaic of textures
function test_segmentation_mosaic
 
    g = @(w,sigma) fspecial('gaussian',w, sigma);
    
    im = imread('P2_seg/mosaic8.tif');
    
    imgaus = imfilter(im,g(31,9),'same'); %figure(20); imshow(imgaus);
    imgaus2 = imfilter(im,g(9,0.5),'same'); 
    imgausdif = abs(imgaus2 - imgaus); imagesc(imgausdif);
    
    
    %BW2 = edge(rgb2gray(imgaus),'canny'); figure(30); imshow(BW2);
    %se = strel('square',5); BWDIL = imdilate(BW2,se); figure(40); imshow(BWDIL);
    
    %imgausdif=im2bw(histeq(rgb2gray(imgausdif)), 0.55); imshow(ab);
    
    % Test 1
%     w = 30; d = 3;
%     vd = [0 d; -d d; -d 0; -d -d];
%     nlvl = 4;
    
    % Test 2
%     w = 9; d = 3;
%     vd = [0 d; -d d; -d 0; -d -d];
%     nlvl = 6;
    
    % Test 3    
%     w = 21; 
%     vd = [0 3; 1 3; 2 3; 3 3; 4 3; 5 3];
%     nlvl = 4;

    % Test 4
    w = 3; 
    vd = [0 1; -1 1; -1 0; -1 -1];
    nlvl = 8;    
    
    %load('mosaic_d11.mat');
    
    %Extract Features
%     im_features = generate_segmentation_data(im, w, vd, nlvl);
%     im_features(:,:,end-2:end) = imgaus;
%     im_features(:,:,end+1) = Ixy;

    
    
    im_features = generate_segmentation_data(im, w, vd, nlvl);
    %im_features = nlfilter(rgb2gray(im), [w w], @(x) nlfun(x, 'Contrast', vd, nlvl) );

%     %Normalize them
    [R,C,F] = size(im_features);
    text_features = reshape(im_features, R*C, F);
    text_features = normalize_features( text_features );
    im_features = reshape(text_features, R, C, F);
    
    figure;
    subplot(1,2,1), region_growing_caller(imgaus, 30);
    
    %Test 1
    %subplot(1,2,2), region_growing_caller(im_features, 5.2);
    
    %Test 2
    %subplot(1,2,2), region_growing_caller(im_features, 5.2);
    
    %Test 3
    subplot(1,2,2), region_growing_caller(im_features, 1.1);
end


%% Test function of the feature extractor with homogeneous figure
function test_segmentation_homogeneous
    %Homogeneous image
    im = ones(6,7,3);
    im(4:6,:,:) = 120

    tic
    toy_features = texture_features_local(im, 3, 0, 1);
    toc
end
 
%% Tester to understand the graycomatrix and graycoprops functions with 
%  the examples seen in the SSI class (slides)
function test_segmentation_slides_example
 
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
 

%% Function for invoking with the nlfilter to calculate the statistics of
%  a comatrix
function x = nlfun(x, feature, d, nlvl)
    
    x = graycomatrix(x, 'Offset',d, 'NumLevels',nlvl, 'Symmetric', true ); %'Symmetric', true);
    x = graycoprops(x,{feature});
    x = struct2array(x);
end
 
 %% Invoker of the local texture feature extractor
 %  This also displays all the obtained features in a figure per angle and
 %  per distance.
 function text_features = generate_segmentation_data(im, w, vd, numlvl) 
    
    im_gray = double( rgb2gray(im) );
    im_gray = mat2gray(im_gray);
    
    tic
    [text_features, ~] = texture_features_local(im_gray, w, vd, numlvl);
    toc
    
    %text_features = nlfilter(im_gray, w, @(t) nlfun(t,'Contrast',dv));
    %text_features(:,:,2) = nlfilter(im_gray, w, @(t) nlfun(t,'Homogeneity',dv));
    %text_features(:,:,3) = nlfilter(im_gray, w, @(t) nlfun(t,'Energy',dv));
    %text_features(:,:,4) = nlfilter(im_gray, w, @(t) nlfun(t,'Correlation',dv));
  
%     text_features(:,:,end+1) = im(:,:,1);  %R
%     text_features(:,:,end+1) = im(:,:,2);  %G
%     text_features(:,:,end+1) = im(:,:,3);  %B
    
    for i=0 : size(vd)-1
        figure
        subplot(1,3,1), imagesc(text_features(:,:,1+i*3)); colormap(gray);
        subplot(1,3,2), imagesc(text_features(:,:,2+i*3)); colormap(gray);
        subplot(1,3,3), imagesc(text_features(:,:,3+i*3)); colormap(gray);
    end
    
%     figure
%     subplot(1,3,1), imagesc(text_features(:,:,end-2)); colormap(gray);
%     subplot(1,3,2), imagesc(text_features(:,:,end-1)); colormap(gray);
%     subplot(1,3,3), imagesc(text_features(:,:,end)); colormap(gray);
 end
 
 %% Invoker of the modified version of region growing.
 %  The new function receives an RxC 
 function region_growing_caller(im, threshold)
 
    % Region growing for color images without filter
    [imlabels, ~] = region_growing(im, threshold);
    rgb = label2rgb(imlabels, 'spring', 'c', 'shuffle'); 
    subimage(rgb);
    
 end