% 20161003359 ÍõµÂºã Gogoing
% Assignment 5

% ori = imread('.\Assignment_5\over_exposed.jpg');
% 
% fixed = imadjust(ori, [], [], 3);
% 
% subplot(1, 2, 1), imshow(ori),
% subplot(1, 2, 2), imshow(fixed);

% Vedio process
v = VideoReader('.\Assignment_5\Iversion.mp4');
n = v.NumberOfFrames;
f = VideoWriter('.\Assignment_5\result.mp4');
open(f)

kernel = [-1 -1 -1 ; -1 8 -1 ; -1 -1 -1];
for ci = 1: n
    frame = read(v, ci);
    r = double(frame(:, :, 1));
    g = double(frame(:, :, 2));
    b = double(frame(:, :, 3));

    % Gaussian Filter
    w = fspecial('gaussian', [5,5], 1);
    r0 = imfilter(r, w, 'conv', 'replicate');
    g0 = imfilter(g, w, 'conv', 'replicate');
    b0 = imfilter(b, w, 'conv', 'replicate');
    % Laplacian sharpening
    r1 = conv2(r0, kernel, 'same');
    g1 = conv2(g0, kernel, 'same');
    b1 = conv2(b0, kernel, 'same');
    
    r = uint8(r) + uint8(r1);
    g = uint8(g) + uint8(g1);
    b = uint8(b) + uint8(b1);
    sharped = cat(3, r, g, b);
    sharped = rgb2hsv(sharped);
    sharped(:, :, 3) = histeq(sharped(:, :, 3));
    sharped = hsv2rgb(sharped);
    writeVideo(f, sharped);
end

close(f);
