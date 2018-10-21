function conv_and_show( ori, k1, k2, k3, k4, k5, n )

f1 = conv_rgb(ori, k1);
f2 = conv_rgb(ori, k2);
f3 = conv_rgb(ori, k3);
f4 = conv_rgb(ori, k4);
f5 = conv_rgb(ori, k5);

figure(n),
subplot(2, 3, 1), imshow(ori),
subplot(2, 3, 2), imshow(f1),
subplot(2, 3, 3), imshow(f2),
subplot(2, 3, 4), imshow(f3),
subplot(2, 3, 5), imshow(f4),
subplot(2, 3, 6), imshow(f5);

end
