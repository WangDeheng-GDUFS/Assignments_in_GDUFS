% 20161003359 ÍõµÂºã Gogoing
% Assignment 1
% 1 A
tif_path = './data/tif_pictures/images/';
other_file_path = './data/other_files/';
% Read the pictures and write to JPEG, PNG, BMP
livingroom_tif = imread(strcat(tif_path, 'livingroom.tif'));
imwrite(livingroom_tif, strcat(other_file_path, 'livingroom.jpeg'), 'jpeg');
imwrite(livingroom_tif, strcat(other_file_path, 'livingroom.png'), 'png');
imwrite(livingroom_tif, strcat(other_file_path, 'livingroom.bmp'), 'bmp');

cameraman_tif = imread(strcat(tif_path, 'cameraman.tif'));
imwrite(cameraman_tif, strcat(other_file_path, 'cameraman.jpeg'), 'jpeg');
imwrite(cameraman_tif, strcat(other_file_path, 'cameraman.png'), 'png');
imwrite(cameraman_tif, strcat(other_file_path, 'cameraman.bmp'), 'bmp');

% Get the filesize of the pictures
file_info_tmp = imfinfo(strcat(tif_path, 'livingroom.tif'));
livingroom_tif_size = file_info_tmp.FileSize;
file_info_tmp = imfinfo(strcat(other_file_path, 'livingroom.jpeg'));
livingroom_jpeg_size = file_info_tmp.FileSize;
file_info_tmp = imfinfo(strcat(other_file_path, 'livingroom.png'));
livingroom_png_size = file_info_tmp.FileSize;
file_info_tmp = imfinfo(strcat(other_file_path, 'livingroom.bmp'));
livingroom_bmp_size = file_info_tmp.FileSize;

file_info_tmp = imfinfo(strcat(tif_path, 'cameraman.tif'));
cameraman_tif_size = file_info_tmp.FileSize;
file_info_tmp = imfinfo(strcat(other_file_path, 'cameraman.jpeg'));
cameraman_jpeg_size = file_info_tmp.FileSize;
file_info_tmp = imfinfo(strcat(other_file_path, 'cameraman.png'));
cameraman_png_size = file_info_tmp.FileSize;
file_info_tmp = imfinfo(strcat(other_file_path, 'cameraman.bmp'));
cameraman_bmp_size = file_info_tmp.FileSize;

% Calculate the compression ratio
tif_to_jpeg = livingroom_tif_size / livingroom_jpeg_size;
tif_to_png = livingroom_tif_size / livingroom_png_size;
tif_to_bmp = livingroom_tif_size / livingroom_bmp_size;

tif_to_jpeg2 = cameraman_tif_size / cameraman_jpeg_size;
tif_to_png2 = cameraman_tif_size / cameraman_png_size;
tif_to_bmp2 = cameraman_tif_size / cameraman_bmp_size;

disp('Compression ratio:')
disp(strcat('tif_to_jpeg  :', num2str(tif_to_jpeg), ':1'));
disp(strcat('tif_to_png   :', num2str(tif_to_png), ':1'));
disp(strcat('tif_to_bmp   :', num2str(tif_to_bmp), ':1'));

disp(' ')
disp(strcat('tif_to_jpeg2 :', num2str(tif_to_jpeg2), ':1'));
disp(strcat('tif_to_png2  :', num2str(tif_to_png2), ':1'));
disp(strcat('tif_to_bmp2  :', num2str(tif_to_bmp2), ':1'));

% 1 B
img_original = imread(strcat(tif_path, 'livingroom.tif'));
img_2 = uint8(floor(double(img_original) / 128) * 128);
img_5 = uint8(floor(double(img_original) / 51.2) * 51.2);
img_8 = uint8(floor(double(img_original) / 32) * 32);
img_16 = uint8(floor(double(img_original) / 16) * 16);
subplot(2, 2, 1), imshow(img_2);
subplot(2, 2, 2), imshow(img_5);
subplot(2, 2, 3), imshow(img_8);
subplot(2, 2, 4), imshow(img_16);
