% 20161003359 ÍõµÂºã Gogoing
% Assignment 2
% Q3
glasses = imread('E:\Program Files\MATLAB\R2016a\workspace\data\icons\icons\icons8-3d-glasses-48.png');

% Quantize
g2 = quantize(glasses, 2);
g5 = quantize(glasses, 5);
g8 = quantize(glasses, 8);
g16 = quantize(glasses, 16);

% Show result
figure(1);
display_channels(g2);
figure(2);
display_channels(g5);
figure(3);
display_channels(g8);
figure(4);
display_channels(g16);
