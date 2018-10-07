function display_channels( rgb_image)
% Display the channels of the rgb image

rgb_image_r = rgb_image(:,:,1);
rgb_image_g = rgb_image(:,:,2);
rgb_image_b = rgb_image(:,:,3);

subplot(2, 2, 1); imshow(rgb_image);
subplot(2, 2, 2); imshow(rgb_image_r);
subplot(2, 2, 3); imshow(rgb_image_g);
subplot(2, 2, 4); imshow(rgb_image_b);
end

