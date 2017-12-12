function [patch1, patch2, patch3, patch4] = get_patch(img, i, j, patch_size)
    size = (patch_size-1)/2;
    patch1 = img(i-2*size:i, j-2*size:j);
    patch2 = img(i:i+2*size, j:j+2*size);
    patch3 = img(i-2*size:i, j:j+2*size);
    patch4 = img(i:i+2*size, j-2*size:j);
    
end