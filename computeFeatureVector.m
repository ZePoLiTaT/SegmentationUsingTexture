function v = computeFeatureVector(A)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

% test: gray mean

% if size(A,3) > 1,
% 	A = rgb2gray(A);
% end

%v = mean(A);

% test color: mean! problem with RGB... bla bla bla 

% [R,C,~] = size(A);
% A = reshape(A, R*C, 3);
% 
% v = mean(A);

% test color: norm of the mean

% [R,C,~] = size(A);
% A = reshape(A, R*C, 3);
% 
% v = sqrt(norm(mean(A)));

% changing color space

colorTransform = makecform('srgb2lab');
A = applycform(A, colorTransform);

[R,C,~] = size(A);
A = reshape(A, R*C, 3);

v = mean(A);

% features

% stats_im = test_classification(A);
% 
% [R,C,~] = size(A);
% A = reshape(A, R*C, 3);
% 
% v = [mean(A) stats_im];
% v = normalize_features(v);

end

function stats_im = test_classification(im)
    im = rgb2gray(im);
    comat_im = graycomatrix(im, 'Offset',[0 2], 'Symmetric', true);
    stats_im = graycoprops(comat_im,{'Contrast','Homogeneity', 'Energy', 'Correlation'});
    stats_im = struct2array( stats_im );
 end













