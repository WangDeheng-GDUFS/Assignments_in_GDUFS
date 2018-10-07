function [ binary_image ] = thresholding( sub_band )
[n_row, n_column] = size(sub_band);
sub_band = im2double(sub_band);
s_martix = double(zeros(n_row, n_column));
binary_image = uint8(zeros(n_row, n_column));

for i = 1: n_row
    for j = 1: n_column
        % Get value of es on the up, down, left and right
        % Define the pixels out of the image as 128
        if i - 1 < 1
            up = sub_band(i, j);
        else
            up = sub_band(i - 1, j);
        end
        if i + 1 > n_row
            down = sub_band(i, j);
        else
            down = sub_band(i + 1, j);
        end
        if j - 1 < 1
            left = sub_band(i, j);
        else
            left = sub_band(i, j - 1);
        end
        if j + 1 > n_column
            right = sub_band(i, j);
        else
            right = sub_band(i, j + 1);
        end
        % Calculate equation s
        s_martix(i, j) = max(abs(up - down), abs(left - right));
    end
end
% Calculate T
es = sub_band;
tmp = es .* s_martix;
Sigma_es_mul_s = sum(tmp);
Sigma_s = sum(s_martix);
T = Sigma_es_mul_s / Sigma_s * 3;
disp(T);

% Thresholding
for i = 1: n_row
    for j = 1: n_column
        if sub_band(i, j) > T
            binary_image(i, j) = 255;
        end
    end
end

end

