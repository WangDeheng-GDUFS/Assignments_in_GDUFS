function [ res ] = conv_rgb( rgb, kernel )
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);

r = convolution_same(r, kernel);
g = convolution_same(g, kernel);
b = convolution_same(b, kernel);

res = cat(3, r, g, b);
end

