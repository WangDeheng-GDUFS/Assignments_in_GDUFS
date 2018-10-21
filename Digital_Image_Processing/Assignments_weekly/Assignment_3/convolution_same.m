function [ res ] = convolution_same( ori, kernel )
    [n_row, n_col] = size(ori);
    [nkr, nkc] = size(kernel);
    res = ori;

    % Reshape the ori and kernel
    re_kernel = rot90(kernel, 2);
    add_row = zeros(1, n_col);
    add_col = zeros(n_row + nkr - 1, 1);
    re_ori = ori;
    for i = 1: nkr - 1
        if mod(i, 2) ~= 0
            re_ori = cat(1, re_ori, add_row);
        else
            re_ori = cat(1, add_row, re_ori);
        end
    end
    for i = 1: nkc - 1
        if mod(i, 2) ~= 0
            re_ori = cat(2, re_ori, add_col);
        else
            re_ori = cat(2, add_col, re_ori);
        end
    end

    % Same convolution
    for i = 1: n_row
        for j = 1: n_col
            % The sliding window
            win = re_ori(i: i + nkr - 1, j: j + nkc - 1);
            tmp = double(win) .* double(re_kernel);
            res(i, j) = sum(tmp(:));
        end
    end
end
