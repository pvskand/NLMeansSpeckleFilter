function loss = SNR(img1, noise)

    num = 0;
    den = 0;
    img1 = double(img1);
    noise = double(noise);
    for i = 1:size(img1, 1)
        for j = 1:size(img1, 2)
            num = num + (img1(i, j)^2 + noise(i, j)^2);
            den = den + (img1(i, j) - noise(i, j))^2;
        end
    end
    num
    den
    loss = double(num) / (double(den) + 10^-13);
    loss = double(loss);
    loss = 10 * log10(loss);
end