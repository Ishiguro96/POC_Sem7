function filtered_image = filt_med (noised_image, mask, is_rgb)

filtered_image = noised_image;

% Make local copy
local_noised_image = noised_image;

mask_offset = (mask - 1) / 2;
image_offset = mask_offset + 1;

if is_rgb == true
    max_layer = 3;
else
    max_layer = 1;
end

mask_array = zeros(mask, mask);

for layer_iter = 1 : max_layer
    % Extract color layer
	layer = local_noised_image(:, :, layer_iter);
	[layer_size_x, layer_size_y] = size(layer);
    for i = image_offset : layer_size_x - mask_offset
        for j = image_offset : layer_size_y - mask_offset
           
            iter = 1; 
            for image_mask_x = (i - mask_offset) : (i + mask_offset) 
                for image_mask_y = (j - mask_offset) : (j + mask_offset)
                    mask_array(iter) = layer(image_mask_x, image_mask_y);
					iter = iter + 1;
                end
            end
            % Convert to 1D array
            mask_array = reshape(mask_array, [], 1);
			layer(i, j) = median(mask_array);
        end
    end
	filtered_image(:, :, layer_iter) = layer;
end

end