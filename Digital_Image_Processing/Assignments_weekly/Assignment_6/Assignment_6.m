% 20161003359 ÍõµÂºã Gogoing
% Assignment 6 U 7

% Q 1
f = zeros(30, 30); 
f(13: 17, 13: 17) = 1; 
F = fft2(f, 256, 256);
F = fftshift(F);
F2 = log(abs(F));
figure(1);
subplot(1, 2, 1), imshow( f,'InitialMagnification', 'fit' ),
subplot(1, 2, 2), imshow(F2, [-1 5 ],'InitialMagnification', 'fit'); 
colormap(jet); colorbar

% Q 2
cm = imread('./data/tif_pictures/images/cameraman.tif'); 
cf = fftshift( fft2( cm )); 
imshow( cm ); 
figure, fftshow(cf, 'log');

[x,y] = meshgrid(-255:256, -255:256); 
z = sqrt(x .^ 2 + y .^ 2); 
c = (z > 15); 

cfl = cf .* c(1:512, 1:512);
figure, fftshow( cfl, 'log');

cfli=ifft2( cfl ); 
figure, fftshow( cfli, 'abs');

% Q 3
B = im2uint8(rgb2gray(imread('blured.png')))
B1 = B(1:255, :);
B2 = B(256:510, :);

D1 = zeros(255, 492); % zero matrix
D2 = D1;
D3 = zeros(510, 492);
m1 = fspecial('motion', 40.3, 45);
m2 = fspecial('motion', 44.6, 45);
m3 = fspecial('motion', 0.7, 90);
[x1, y1] = size(m1);
[x2, y2] = size(m2);
[x3, y3] = size(m3);
D1(1:x1, 1:y1) = m1;
D2(1:x2, 1:y2) = m2;
D3(1:x3, 1:y3) = m3;

d = 0.05;
Df1 = fft2(D1);
Df2 = fft2(D2);
Df3 = fft2(D3);
Df1(find(abs(Df1) < d)) = 1;
Df2(find(abs(Df2) < d)) = 1;
Df3(find(abs(Df3) < d)) = 1; % DFT of filter
Db1 = ifft2(fft2( B1 ) ./ Df1);
Db2 = ifft2(fft2( B2 ) ./ Df2);
Db = cat(1, Db1, Db2);
Db = ifft2(fft2( Db ) ./ Df3);
figure, imshow(mat2gray(abs( Db )) * 2);










