clc; clearvars;

img1 = imread('images/phantom_noisy.png');
img1 = padarray(img1,6, 'replicate');
img1 = imresize(img1, 0.5);
img1 = rgb2gray(img1);


search_window = 6; % search window for NL means
patch_size = 3;     % patch size for comparison
epsilon = 10^-13;   % to handle 0/0 cases

g_mean = mean(double(img1(:))); % mean 
g_var = var(double(img1(:)));   % variance

filter = ones(size(img1, 1), size(img1, 2));

for i = 1:size(img1, 1)
    for j = 1:size(img1, 2)
        
        if check_img(img1, i, j, search_window, patch_size) == 1
            [patch1, patch2, patch3, patch4] = get_patch(img1, i, j, patch_size); % 4 overlapping patches around pixel (i, j)
            
            % Mean and Variance of patches
            mean_patch1 = mean(double(patch1(:))) + epsilon; 
            var_patch1 = var(double(patch1(:))) + epsilon;
            
            mean_patch2 = mean(double(patch2(:))) + epsilon;
            var_patch2 = var(double(patch2(:))) + epsilon;
            
            mean_patch3 = mean(double(patch3(:))) + epsilon;
            var_patch3 = var(double(patch3(:))) + epsilon;
            
            mean_patch4 = mean(double(patch4(:))) + epsilon;
            var_patch4 = var(double(patch4(:))) + epsilon;
            
            count = 0;
            v1 = []; v2 = []; v3 = []; v4 = [];
            loc1 = []; loc2 = []; loc3 = []; loc4 = [];
            % Block wise comparisions with Pearson Distance
            for x = int16(i-(search_window-1)/2) : int16(i+(search_window-1)/2)
                for y = int16(j-(search_window-1)/2) : int16(j+(search_window-1)/2)
                    sub_patch = get_patch_single(img1, x, y, patch_size);
                    mean_sub_patch = mean(double(sub_patch(:))) + epsilon;
                    var_sub_patch = var(double(sub_patch(:))) + epsilon;
                    if (mean_patch1/mean_sub_patch < g_mean && mean_patch1/mean_sub_patch > 1/g_mean) && (var_patch1/var_sub_patch < g_var && var_patch1/var_sub_patch > 1/g_var)
                        count = count + 1;
                        norm = similarity(patch1, sub_patch);
                        v1 = [v1, norm];
                        loc1 =[loc1; img1(x, y)];
                        
                    end
                    
                     if (mean_patch2/mean_sub_patch < g_mean && mean_patch2/mean_sub_patch > 1/g_mean) && (var_patch2/var_sub_patch < g_var && var_patch2/var_sub_patch > 1/g_var)
                        count = count + 1;
                        norm = similarity(patch2, sub_patch);
                        v2 = [v2, norm];
                        loc2 =[loc2; img1(x, y)]; 
                     end
                    if (mean_patch3/mean_sub_patch < g_mean && mean_patch3/mean_sub_patch > 1/g_mean) && (var_patch3/var_sub_patch < g_var && var_patch3/var_sub_patch > 1/g_var)
                        count = count + 1;
                        norm = similarity(patch3, sub_patch);
                        v3 = [v3, norm];
                        loc3 =[loc3; img1(x, y)];
                    end
                    if (mean_patch4/mean_sub_patch < g_mean && mean_patch4/mean_sub_patch > 1/g_mean) && (var_patch4/var_sub_patch < g_var && var_patch4/var_sub_patch > 1/g_var)
                        count = count + 1;
                        norm = similarity(patch4, sub_patch);
                        v4 = [v4, norm];
                        loc4 =[loc4; img1(x, y)];
                    end
                end
            end
            v1_sum = sum(v1);
            v1 = (v1+10^-13)/(v1_sum+10^-13);
            
            v2_sum = sum(v2);
            v2 = (v2+10^-13)/(v2_sum+10^-13);
            
            v3_sum = sum(v3);
            v3 = (v3+10^-13)/(v3_sum+10^-13);
            
            v4_sum = sum(v4);
            v4 = (v4+10^-13)/(v4_sum+10^-13);
            
            pixel1 = double(v1) * double(loc1);
            pixel2 = double(v2) * double(loc2);
            pixel3 = double(v3) * double(loc3);
            pixel4 = double(v4) * double(loc4);
                
            filter(i, j) = (pixel1 + pixel2 + pixel3 + pixel4)/4; % taking average of blocks
        end
        
    end
    fprintf('Completed Pixel %d %d\n', i, j);
end


figure; subplot 121; imshow(img1); subplot 122;

imshow(uint8(filter));



