function [ res ] = resampling_avg( ori, tr, tc )
% tr and tr means times of row and column
    tmp = [];
    res = [];
    [nr, nc] = size(ori);
    for r = 1: nr
        if r < nr
            tmp_row = ori(r + 1, :) - ori(r, :);
            tmp_row = tmp_row / tr - 1;
        end
        for i = 1: tr;
            tmp = cat(1, tmp, ori(r, :) + tmp_row * (i - 1));
        end
    end

    for c = 1: nc
        if c < nc
            tmp_column = tmp(:, c + 1) - tmp(:, c);
            tmp_column = tmp_column / tr - 1;
        end
        for i = 1: tc;
            res = cat(2, res, tmp(:, c) + tmp_column * (i - 1));
        end
    end
end
