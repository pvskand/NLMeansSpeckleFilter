function [check] = check_img(img, i, j, window_size, patch_size)

    check = 1;
    size1 = (window_size-1)/2;
    size2 = (patch_size-1)/2;
    if i-(size1+size2) < 0 || j-(size1+size2) < 0 || i+(size1+size2)>size(img, 1) || j+(size1+size2)>size(img, 2)
        check = 0;
    end
    
    


end