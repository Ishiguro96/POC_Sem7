% =====================
% |     POC LAB 1     |
% |       SEM 7       |
% | Dawid Tobor gr. 4 |
% =====================

close all
clear variables
clc

disp ('Script is working. Please wait...');

% Salt & pepper noise is used
[org_img, noised_img, noised_bw_img] = gen_noise('../images/color/bangko_13_512x512', 'imp', 0.02, false, '', true, '');
bw_img = rgb2gray(org_img);

[org_img2, noised_img2, noised_bw_img2] = gen_noise('../images/color/14_512x512', 'imp', 0.1, false, '', true, '');
bw_img2 = rgb2gray(org_img2);

filt_img3 = filt_med(noised_bw_img, 3, false);
filt_img5 = filt_med(noised_bw_img, 5, false);
filt_img_lum1 = filt_lum(noised_bw_img, 3, 1, false);
filt_img_lum3 = filt_lum(noised_bw_img, 3, 3, false);

filt_img3_2 = filt_med(noised_bw_img2, 3, false);
filt_img5_2 = filt_med(noised_bw_img2, 5, false);
filt_img_lum1_2 = filt_lum(noised_bw_img2, 3, 1, false);
filt_img_lum3_2 = filt_lum(noised_bw_img2, 3, 3, false);

PSNR1_1 = psnr(filt_img3(2:end-1,2:end-1,:), bw_img(2:end-1,2:end-1,:));
PSNR1_2 = psnr(filt_img5(3:end-1,2:end-1,:), bw_img(3:end-1,2:end-1,:));
PSNR1_3 = psnr(filt_img_lum1(2:end-1,2:end-1,:), bw_img(2:end-1,2:end-1,:));
PSNR1_4 = psnr(filt_img_lum3(2:end-1,2:end-1,:), bw_img(2:end-1,2:end-1,:));

PSNR2_1 = psnr(filt_img3_2(2:end-1,2:end-1,:), bw_img2(2:end-1,2:end-1,:));
PSNR2_2 = psnr(filt_img5_2(3:end-1,3:end-1,:), bw_img2(3:end-1,3:end-1,:));
PSNR2_3 = psnr(filt_img_lum1_2(2:end-1,2:end-1,:), bw_img2(2:end-1,2:end-1,:));
PSNR2_4 = psnr(filt_img_lum3_2(2:end-1,2:end-1,:), bw_img2(2:end-1,2:end-1,:));

figure;
subplot(2,4,1);  imshow(bw_img); title('Original image');
subplot(2,4,2);  imshow(noised_bw_img); title('Noised image (2%)');
subplot(2,4,3);  imshow(filt_img3); title(['Filtered image - median (3x3), PSNR = ', num2str(PSNR1_1)]);
subplot(2,4,4);  imshow(filt_img5); title(['Filtered image - median (5x5), PSNR = ', num2str(PSNR1_2)]);
subplot(2,4,7);  imshow(filt_img_lum1); title(['Filtered image - LUM k=1, PSNR = ', num2str(PSNR1_3)]);
subplot(2,4,8);  imshow(filt_img_lum3); title(['Filtered image - LUM k=3, PSNR = ', num2str(PSNR1_4)]);

figure;
subplot(2,4,1);  imshow(bw_img2); title('Original image');
subplot(2,4,2);  imshow(noised_bw_img2); title('Noised image (10%)');
subplot(2,4,3);  imshow(filt_img3_2); title(['Filtered image - median (3x3), PSNR = ', num2str(PSNR2_1)]);
subplot(2,4,4);  imshow(filt_img5_2); title(['Filtered image - median (5x5), PSNR = ', num2str(PSNR2_2)]);
subplot(2,4,7);  imshow(filt_img_lum1_2); title(['Filtered image - LUM k=1, PSNR = ', num2str(PSNR2_3)]);
subplot(2,4,8);  imshow(filt_img_lum3_2); title(['Filtered image - LUM k=3, PSNR = ', num2str(PSNR2_4)]);

% VMF Filtering

filt_img_c = filt_med(noised_img, 3, true);
filt_img_c2 = filt_med(noised_img2, 3, true);
filt_imgvmf3 = filt_vmf(noised_img, 3);
filt_imgvmf5 = filt_vmf(noised_img, 5);
filt_imgvmf3_2 = filt_vmf(noised_img2, 3);
filt_imgvmf5_2 = filt_vmf(noised_img2, 5);

PSNR3_1 = psnr(filt_img_c(2:end-1,2:end-1,:), org_img(2:end-1,2:end-1,:));
PSNR3_2 = psnr(filt_imgvmf3(2:end-1,2:end-1,:), org_img(2:end-1,2:end-1,:));
PSNR3_3 = psnr(filt_imgvmf5(3:end-2,3:end-2,:), org_img(3:end-2,3:end-2,:));

PSNR4_1 = psnr(filt_img_c2(2:end-1,2:end-1,:), org_img2(2:end-1,2:end-1,:));
PSNR4_2 = psnr(filt_imgvmf3_2(2:end-1,2:end-1,:), org_img2(2:end-1,2:end-1,:));
PSNR4_3 = psnr(filt_imgvmf5_2(3:end-2,3:end-2,:), org_img2(3:end-2,3:end-2,:));

figure;
subplot(2,3,1);  imshow(org_img(200:300,200:300,:)); title('Original image');
subplot(2,3,2);  imshow(noised_img(200:300,200:300,:)); title('Noised image (2%)');
subplot(2,3,3);  imshow(filt_img_c(200:300,200:300,:)); title(['Filtered image - scalar median (3x3), PSNR = ', num2str(PSNR3_1)]);
subplot(2,3,5);  imshow(filt_imgvmf3(200:300,200:300,:)); title(['Filtered image - VMF (3x3), PSNR = ', num2str(PSNR3_2)]);
subplot(2,3,6);  imshow(filt_imgvmf5(200:300,200:300,:)); title(['Filtered image - VMF (5x5), PSNR = ', num2str(PSNR3_3)]);

figure;
subplot(2,3,1);  imshow(org_img2); title('Original image');
subplot(2,3,2);  imshow(noised_img2); title('Noised image (10%)');
subplot(2,3,3);  imshow(filt_img_c2); title(['Filtered image - scalar median (3x3), PSNR = ', num2str(PSNR4_1)]);
subplot(2,3,5);  imshow(filt_imgvmf3_2); title(['Filtered image - VMF (3x3), PSNR = ', num2str(PSNR4_2)]);
subplot(2,3,6);  imshow(filt_imgvmf5_2); title(['Filtered image - VMF (5x5), PSNR = ', num2str(PSNR4_3)]);

clc
disp ('Finished :)');
