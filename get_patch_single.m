function [patch] = get_patch_single(img, i, j, patch_size)
    size = int16((patch_size-1)/2);
    
    patch = img(i-size:i+size, j-size:j+size);
    

    
end