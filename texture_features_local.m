function [ features ] = texture_features_local( im, wsize )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


    fun = @(x) graycomatrix(x, 'Offset',[0 1], 'NumLevels',4, 'GrayLimits', [0 3], 'Symmetric', true);
    features = nlfilter(im,[3 3],fun);

end

