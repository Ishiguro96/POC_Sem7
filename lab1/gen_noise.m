% Function to generate noised images

function [origin_image, noised_image, noised_bw_image] = gen_noise (image_path_without_extension, ...
                                                                    noise_type, ...
                                                                    noise_power, ...
                                                                    save_to_file, ...
                                                                    filename, ...
                                                                    gen_black_white, ...
                                                                    black_white_filename)

origin_image = imread([image_path_without_extension, '.bmp']);

% Optional step - take only small piece of image
%max_size = 155;
%origin_image = origin_image(1:max_size, 1:max_size, :);

if gen_black_white == true
    black_white_image = rgb2gray(origin_image);
end

switch noise_type
    case 'imp'
        noised_image = imnoise(origin_image, 'salt & pepper', noise_power);
        if gen_black_white == true
            noised_bw_image = imnoise(black_white_image, 'salt & pepper', noise_power);
        end
        
    case 'gauss'
        noised_image = imnoise(origin_image, 'gaussian', noise_power);
        if gen_black_white == true
            noised_bw_image = imnoise(black_white_image, 'gaussian', noise_power);
        end
        
    case 'mixed'
        noised_image = imnoise(origin_image, 'gaussian', noise_power);
        noised_image = imnoise(noised_image, 'salt & pepper', noise_power);
        if gen_black_white == true
            noised_bw_image = imnoise(black_white_image, 'gaussian', noise_power);
            noised_bw_image = imnoise(noised_bw_image, 'salt & pepper', noise_power);
        end
        
    otherwise     
end

if save_to_file == true
    imwrite(noised_image, filename);
end

if gen_black_white == true && save_to_file == true 
    imwrite(noised_bw_image, black_white_filename);
end

end