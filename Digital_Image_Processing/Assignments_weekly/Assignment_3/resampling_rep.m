function [ res ] = resampling_rep( ori, tr, tc )
% tr and tr means times of row and column
    tmp = [];
    res = [];
    [nr, nc] = size(ori);
    for r = 1: nr
       for i = 1: tr;
           if i > tr / 2 && r < nr
               tmp = cat(1, tmp, ori(r + 1, :));
           else
               tmp = cat(1, tmp, ori(r, :));
           end
       end
    end

    for c = 1: nc
       for i = 1: tc;
           if i > tc / 2 && c < nc
               res = cat(2, res, tmp(:, c + 1));
           else
               res = cat(2, res, tmp(:, c));
           end
       end
    end
end
