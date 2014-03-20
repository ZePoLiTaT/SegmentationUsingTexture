load('text_features.mat')
[R,C,F] = size(text_features);
text_features = reshape(text_features, R*C, F);
text_features = normalize_features( text_features );
im_features = reshape(text_features, R, C, F);

b=text_features(:,:,4);
b(isnan(b))=1;
text_features(:,:,4)=b;


a=reshape(im_features, R*C, F);
max(a)
mean(a)
min(a)
sqrt(norm(mean(a)))

figure
subplot(1,3,1), imagesc(text_features(:,:,1)); colormap(gray);
subplot(1,3,2), imagesc(text_features(:,:,2)); colormap(gray);
subplot(1,3,3), imagesc(text_features(:,:,3)); colormap(gray);

figure
subplot(1,3,1), imagesc(text_features(:,:,4)); colormap(gray);
subplot(1,3,2), imagesc(text_features(:,:,5)); colormap(gray);
subplot(1,3,3), imagesc(text_features(:,:,6)); colormap(gray);

figure
subplot(1,3,1), imagesc(text_features(:,:,7)); colormap(gray);
subplot(1,3,2), imagesc(text_features(:,:,8)); colormap(gray);
subplot(1,3,3), imagesc(text_features(:,:,9)); colormap(gray);

%Test segmentation
[imlabels, ~] = region_growing(im1, 40); rgb = label2rgb(imlabels,'hsv'); subplot(1,2,1), imshow(rgb)
[imlabels, ~] = region_growing(im_features, 3.1); rgb = label2rgb(imlabels,'hsv'); subplot(1,2,2), imshow(rgb)

[coef,score,latent] = princomp(text_features);

%Images:
%   orientation 0, 90, [0,90]
%       statistics

%Mosaic:
%   confusion matrix
%   roc
%   scores
%   Tiempos



%Score
%Tiempos

[L, ~] = region_growing(im_features, 5.8); rgb = label2rgb(L, 'Jet', 'c', 'shuffle'); subimage(rgb);
