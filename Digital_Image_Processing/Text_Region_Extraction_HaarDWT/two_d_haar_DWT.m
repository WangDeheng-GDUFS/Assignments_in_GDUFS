function [ sub_bands ] = two_d_haar_DWT( gray_image )
% 2 dimensional discrete wavelet transform

% Get the number of rows and columns of the image
[n_row, n_column] = size(gray_image);

% Do 1-D DWT twice 
for row_index = 1: n_row
    row = gray_image(row_index, :);
    temp = uint8(zeros(1, n_column));
    for column_index = 1: n_column / 2
       temp(column_index) = row(column_index * 2 - 1) + row(column_index * 2);
       temp(column_index + n_column / 2) = row(column_index * 2 - 1) - row(column_index * 2);
    end
    gray_image(row_index, :) = temp;
end
% The second time
for column_index = 1: n_column
    column = gray_image(:, column_index);
    temp = uint8(zeros(n_row, 1));
    for row_index = 1: n_row / 2
       temp(row_index) = column(row_index * 2 - 1) + column(row_index * 2);
       temp(row_index + n_row / 2) = column(row_index * 2 - 1) - column(row_index * 2);
    end
    gray_image(:, column_index) = temp;
end
% Get sub_bands
sub_bands = gray_image / 1.44;

end
