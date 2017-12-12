function [sim] = similarity(patch1, patch2)
    % Pearson Distance     
    diff = (double(patch1)-double(patch2)).*(double(patch1)-double(patch2));

    diff = diff ./ double(patch2);
    
    sim = sum(diff(:));
    sim = exp(-(sim/10));
    
end