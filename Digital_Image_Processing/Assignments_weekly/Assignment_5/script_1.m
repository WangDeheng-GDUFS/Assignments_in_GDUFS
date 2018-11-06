% c = imread('E:\Program Files\MATLAB\R2016a\workspace\data\week5\01.jpg');
% L = ones( 512 ) * 256;
% i = ones( 512 );
% r = rgb2gray(c);
% s = uint8 ( L ) - uint8 ( i ) - r;
% 
% figure(1);
% subplot ( 1, 2, 1); imshow ( c ); 
% subplot ( 1, 2, 2); imshow ( s );
% 
% c1 = imread('E:\Program Files\MATLAB\R2016a\workspace\data\chino_cocoa.jpg');
% L = ones( size(c1(:, :, 1)) ) * 256;
% i = ones( size(c1(:, :, 1)) );
% 
% rr = c1(:, :, 1);
% rg = c1(:, :, 2);
% rb = c1(:, :, 3);
% 
% sr = uint8 ( L ) - uint8 ( i ) - rr;
% sg = uint8 ( L ) - uint8 ( i ) - rg;
% sb = uint8 ( L ) - uint8 ( i ) - rb;
% 
% s1 = cat(3, sr, sg, sb);
% figure(2);
% subplot ( 1, 2, 1); imshow ( c1 ); 
% subplot ( 1, 2, 2); imshow ( s1 );
% 
% s = imadjust(r);
% figure, imshow(r), figure, imshow(s);
% 
% r = rgb2gray(c);
% s = imadjust(r, [(15/256) (75/256)], [0 1] );
% figure, imshow(r), figure, imshow(s);
% 
% r = rgb2gray(c);
% s = imadjust(r, [(15/256) (75/256)], [0 1], 0.5 );
% figure, imshow(r), figure, imshow(s);

v = VideoReader('E:\Program Files\MATLAB\R2016a\workspace\data\week5\unit6.mp4');
n = v.NumberOfFrames;
for ci = 1: n
    img = read(v, ci);
    r = rgb2gray(img);
    s = imadjust(r, [(0/256) (50/256)], [0 1] );
    imshowpair(img, r, 'montage');
end;

