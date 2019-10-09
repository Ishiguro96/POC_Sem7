close all
clear variables
clc

ob = imread('../images/color/05_512x512.bmp');

szum_imp5 = imnoise(ob, 'salt & pepper', 0.05);

szum_gauss10= imnoise(ob, 'gaussian', 0.10);

szum_miesz = imnoise(ob, 'gaussian', 0.05);
szum_miesz = imnoise(ob, 'salt & pepper', 0.10);

%figure, imshow(ob)
%figure, imshow(szum_imp5)
imwrite(szum_miesz, 'images/barb_512x512_noise.bmp')

ob_med = szum_miesz;
ob_lum = szum_miesz;
maska = 3;
pix = (maska-1)/2;
pix2 = pix+1;

for kolor = 1 : 1
	maska = ob_med(:, :, kolor);
	rozmiar = size(maska);
    for i = pix2 : rozmiar(1)-pix
        for j = pix2 : rozmiar(2)-pix
            piksel=1;
            for im = i-pix : 1 : i+pix 
                for jm = j-pix:1:j+pix
                    A(piksel) = maska(im, jm);
					piksel = piksel + 1;
                end
            end
			B = sort(A);
			maska(i, j) = mean(A);
        end
    end
	ob_med(:, :, kolor) = maska;
end

out = lum(ob_lum, 2);


%figure, imshow(ob_med)
imwrite(ob_med, 'images/gen_3med_3x3.bmp')
imwrite(out, 'images/gen2.bmp');

ob_vmf = szum_imp5;

ob_vmf = double(ob_vmf);
rozmiar = size(ob_vmf);

maska = 3;
pix = (maska-1)/2;
pix2 = pix+1;
for i=pix2:rozmiar-pix2
	for j=pix2:rozmiar-pix2
		R = reshape(ob_vmf(i-pix:i+pix, j-pix:j+pix, 1), maska*maska, 1);
		G = reshape(ob_vmf(i-pix:i+pix, j-pix:j+pix, 2), maska*maska, 1);
		B = reshape(ob_vmf(i-pix:i+pix, j-pix:j+pix, 3), maska*maska, 1);
		W = [R G B];
			
		B(1:maska*maska) = sum(dist(W(1:maska*maska,:), W(1:maska*maska,:)'));

		if(max(ob_vmf(i,j,:)) > (0.9*255) || min( ob_vmf(i,j,:)) < (0.1*255)) 
              if(var(ob_vmf(i,j,:)) > 0.01*255)
                ob_vmf(i,j,:) = W(find(B==min(B),1),:);
              end
        else
        end
    end
end
ob_vmf = uint8(ob_vmf);
%figure, imshow(ob_vmf);

imwrite(ob_vmf, 'images/3_vmf_3x3_modded.png')