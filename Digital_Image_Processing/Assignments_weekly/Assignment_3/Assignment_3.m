% 20161003359 ÍõµÂºã Gogoing
% Assignment 2
% Q 1
ori = imread('E:\Program Files\MATLAB\R2016a\workspace\data\tif_pictures\images\lena_color_256.tif');
path = 'E:\Program Files\MATLAB\R2016a\workspace\data\program_results\Assignment_3\';

r = ori(:, :, 1);
g = ori(:, :, 2);
b = ori(:, :, 3);

r1 = imresize(r, 0.25);
g1 = imresize(g, 0.25);
b1 = imresize(b, 0.25);

r2 = imresize(r, 5);
g2 = imresize(g, 5);
b2 = imresize(b, 5);

res1 = cat(3, r1, g1, b1);
res2 = cat(3, r2, g2, b2);

figure(1);
subplot(1, 2, 1), imshow(res1),
subplot(1, 2, 2), imshow(res2);

% Q 2.1
kernel = [-1 0 0 0 1; -1 0 0 0 1; -1 0 0 0 1; -1 0 0 0 1; -1 0 0 0 1;];
r3 = conv2(r, kernel, 'same');
g3 = conv2(g, kernel, 'same');
b3 = conv2(b, kernel, 'same');

res3 = cat(3, r3, g3, b3);
figure(2);
imshow(res3);

% Q 2.2
kernel2 = [1 2 1; 0 0 0; -1 -2 -1];
r4 = convolution_same(r, kernel2);
g4 = convolution_same(g, kernel2);
b4 = convolution_same(b, kernel2);

res4 = cat(3, r4, g4, b4);
figure(3);
imshow(res4);

% Q 3
x = imread('E:\Program Files\MATLAB\R2016a\workspace\data\tif_pictures\images\cameraman.tif');
% Dither to 8 greylevels
D = [0 24; 36 12];
r = repmat(D, 256, 256);
xd = double(x);

q = floor(xd / 36);
p = q + (xd - 36 * q > r);

figure(4);
imshow(uint8(36 * p));

% Q 4
x1 = mod(xd, 2);
x2 = mod(floor(xd / 2), 2);
x3 = mod(floor(xd / 4), 2);
x4 = mod(floor(xd / 8), 2);
x5 = mod(floor(xd / 16), 2);
x6 = mod(floor(xd / 32), 2);
x7 = mod(floor(xd / 64), 2);
x8 = mod(floor(xd / 128), 2);

figure(5);
subplot(3, 3, 1), imshow(x),
subplot(3, 3, 2), imshow(x1),
subplot(3, 3, 3), imshow(x2),
subplot(3, 3, 4), imshow(x3),
subplot(3, 3, 5), imshow(x4),
subplot(3, 3, 6), imshow(x5),
subplot(3, 3, 7), imshow(x6),
subplot(3, 3, 8), imshow(x7),
subplot(3, 3, 9), imshow(x8);

% Q 5
% Dither matrices
D1 = [128 64 32 64 128; 128 64 32 64 128; 128 64 32 64 128; 128 64 32 64 128; 128 64 32 64 128];
D2 = [32 64 128 64 128; 32 64 128 64 128; 32 64 128 64 128; 32 64 128 64 128; 32 64 128 64 128];
D3 = [32 32 32 32 32; 32 64 64 64 32; 32 64 128 64 32; 32 64 64 64 32; 32 32 32 32 32];
D4 = [192 168 32 168 192; 192 168 32 168 192; 192 168 32 168 192; 192 168 32 168 192; 192 168 32 168 192];
D5 = [168 64 128 64 168; 168 64 128 64 168; 168 64 128 64 168; 168 64 128 64 168; 168 64 128 64 168];
D5 = D5';

r1 = repmat(D1, 510 / 5, 510 / 5);
r2 = repmat(D2, 510 / 5, 510 / 5);
r3 = repmat(D3, 510 / 5, 510 / 5);
r4 = repmat(D4, 510 / 5, 510 / 5);
r5 = repmat(D5, 510 / 5, 510 / 5);

tmp = x;
x = x(1:510, 1:510);
p1 = x > r1;
p2 = x > r2;
p3 = x > r3;
p4 = x > r4;
p5 = x > r5;
fs_res = dither(x);
x = tmp;

figure(6);
subplot(3, 3, 1), imshow(x),
subplot(3, 3, 2), imshow(p1),
subplot(3, 3, 3), imshow(p2),
subplot(3, 3, 4), imshow(p3),
subplot(3, 3, 5), imshow(p4),
subplot(3, 3, 6), imshow(p5),
subplot(3, 3, 7), imshow(fs_res);

% Q 6
rr = resampling_rep(x, 5, 5);
ra = resampling_avg(x, 5, 5);
ke = [0.25 0.5 0.25; 0.5 1 0.5; 0.25 0.5 0.25];
rc = resampling_con(x, 2, 2, ke);

figure(7);
subplot(2, 2, 1), imshow(x),
subplot(2, 2, 2), imshow(rr),
subplot(2, 2, 3), imshow(ra),
subplot(2, 2, 4), imshow(rc);

% Q 7
% Q 7 a Sharpness Filter
ori2 = imread('E:\Program Files\MATLAB\R2016a\workspace\data\chino_cocoa.jpg');
k1 = [-1 -1 -1; -1 9 -1; -1 -1 -1]; 
k2 = [0 -1 0; -1 5 -1; 0 -1 0];
k3 = [1 1 1; 1 -7 1; 1 1 1];
k4 = [-1 0 -1; 0 5 0; -1 0 -1];
k5 = [0 1 0; 1 -3 1; 0 1 0];

conv_and_show(ori2, k1, k2, k3, k4, k5, 8);
% Q 7 b Edge Detection
k1 = [1 1 1; 0 0 0; -1 -1 -1];
k2 = k1';
k3 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
k4 = [-0.125 -0.125 -0.125; -0.125 1 -0.125;-0.125 -0.125 -0.125];
k5 = [-1 0 -1; 0 4 0; -1 0 -1];

conv_and_show(ori2, k1, k2, k3, k4, k5, 9);
% Q 7 c Embossing Filter
k1 = [2 0 0; 0 -1 0; 0 0 -1];
k2 = [-1 -1 0; -1 0 1; 0 1 1];
k3 = rot90(k2, 1);
k4 = rot90(k1, 1);
k5 = [2 2 2; -1 -1 -1; -1 -1 -1];

conv_and_show(ori2, k1, k2, k3, k4, k5, 10);

% Q 7 d Separable kernel
% Edge detection
k = [1; 0; -1] * [1 1 1];
f = conv_rgb(ori2, k);
figure(11);
imshow(f);

% Q 7 e Box Filtering
k1 = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
k2 = [0.25 0 0.25; 0 0 0; 0.25 0 0.25];
k3 = [0 0.25 0; 0.25 0 0.25; 0 0.25 0];

f1 = conv_rgb(ori2, k1);
f2 = conv_rgb(ori2, k2);
f3 = conv_rgb(ori2, k3);

figure(12),
subplot(2, 2, 1), imshow(ori2),
subplot(2, 2, 2), imshow(f1),
subplot(2, 2, 3), imshow(f2),
subplot(2, 2, 4), imshow(f3);

% Q 7 f Gaussian Filter
k1 = [1/16 2/16 1/16; 2/16 4/16 2/16; 1/16 2/16 1/16];
k2 = [1 3 1; 3 6 3; 1 3 1] / 22;
k3 = [2 5 2; 5 8 5; 2 5 2] / 36;

f1 = conv_rgb(ori2, k1);
f2 = conv_rgb(ori2, k2);
f3 = conv_rgb(ori2, k3);

figure(13),
subplot(2, 2, 1), imshow(ori2),
subplot(2, 2, 2), imshow(f1),
subplot(2, 2, 3), imshow(f2),
subplot(2, 2, 4), imshow(f3);
