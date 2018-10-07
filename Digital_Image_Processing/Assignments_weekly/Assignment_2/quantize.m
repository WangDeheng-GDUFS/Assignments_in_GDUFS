function [A] = quantize(A, level)
% To reduce the level of rgb image
%     Input paramater A is an 256 level rgb image
%     Input paramater level means the target level

n = double(256) / level;
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);

fr = floor(double(R) / n);
fg = floor(double(G) / n);
fb = floor(double(B) / n);

qr = uint8(fr * n);
qg = uint8(fg * n);
qb = uint8(fb * n);

A(:,:,1) = qr;
A(:,:,2) = qg;
A(:,:,3) = qb;
end
