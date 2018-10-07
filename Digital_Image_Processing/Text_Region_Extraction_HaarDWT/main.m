original = imread('E:\Program Files\MATLAB\R2016a\workspace\data\text_region_extraction\newspaper_8.jpg');
original = original(1:816, :, :);
gray = rgb2gray(original);
sub_bands = two_d_haar_DWT(gray);
imwrite(sub_bands, 'E:\Program Files\MATLAB\R2016a\workspace\data\text_region_extraction\newspaper_8_sub_bands.jpg');
[n_row, n_column] = size(sub_bands);
LL = sub_bands(1: n_row / 2, 1: n_column / 2);
LH = sub_bands(n_row / 2 + 1: n_row, 1: n_column / 2);
HL = sub_bands(1: n_row / 2,  n_column / 2 + 1: n_column);
HH = sub_bands(n_row / 2 + 1: n_row, n_column / 2 + 1: n_column);

LH = thresholding(LH);
HL = thresholding(HL);
HH = thresholding(HH);

% Operators
vertical = [1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1;];
horizontal = [1 1 1 1; 1 1 1 1; 1 1 1 1; 1 1 1 1; 1 1 1 1; 1 1 1 1;];
diagonal = [1 1 1;1 1 1;1 1 1;1 1 1;];

% Morphological dilations
HL = imdilate(HL, vertical);
LH = imdilate(LH, horizontal);
HH = imdilate(HH, diagonal);


imwrite(LH, 'E:\Program Files\MATLAB\R2016a\workspace\data\text_region_extraction\newspaper_8_LH.jpg');
imwrite(HL, 'E:\Program Files\MATLAB\R2016a\workspace\data\text_region_extraction\newspaper_8_HL.jpg');
imwrite(HH, 'E:\Program Files\MATLAB\R2016a\workspace\data\text_region_extraction\newspaper_8_HH.jpg');
