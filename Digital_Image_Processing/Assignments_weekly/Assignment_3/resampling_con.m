function [ res ] = resampling_con( ori, tr, tc, ke )
% tr and tr means times of row and column
% ke means kernel
    tmp = [];
    res = [];
    [nr, nc] = size(ori);
    for r = 1: nr
       for i = 1: tr;
           if i == 1
               tmp = cat(1, tmp, ori(r, :));
           else
               tmp = cat(1, tmp, zeros(1, nc));
           end
       end
    end

    for c = 1: nc
       for i = 1: tc;
           if i == 1
               res = cat(2, res, tmp(:, c));
           else
               res = cat(2, res, zeros(nr * tr, 1));
           end
       end
    end
    res = convolution_same(res, ke);
end
