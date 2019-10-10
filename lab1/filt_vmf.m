function filtered_image = filt_vmf (noised_image, mask)

filtered_image = noised_image;

% Make local copy
local_noised_image = noised_image;

local_noised_image = double(local_noised_image);
img_size = size(local_noised_image);

mask_offset = (mask - 1) / 2;
image_offset = mask_offset + 1;

for i = image_offset : img_size - image_offset
    for j = image_offset : img_size - image_offset
        R = reshape(local_noised_image(i-mask_offset:i+mask_offset, j-mask_offset:j+mask_offset, 1), mask*mask, 1);
        G = reshape(local_noised_image(i-mask_offset:i+mask_offset, j-mask_offset:j+mask_offset, 2), mask*mask, 1);
        B = reshape(local_noised_image(i-mask_offset:i+mask_offset, j-mask_offset:j+mask_offset, 3), mask*mask, 1);
        W = [R G B];
        
        B(1:mask*mask) = sqrt(sum((dist(W(1:mask*mask,:), W(1:mask*mask,:)'))^2));
        local_noised_image(i,j,:) = W(find(B==min(B),1),:);
    end
end

local_noised_image = uint8(local_noised_image);
filtered_image = local_noised_image;

end