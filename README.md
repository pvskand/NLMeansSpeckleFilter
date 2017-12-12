This folder contains the following:
1) images : A directory containing sample images for testing
2) block_filter.m - main MATLAB file that outputs the restored image
3) check_img.m - A helper function
4) similarity.m - Pearson Distance
5) get_patch.m - To get a patch around pixel (x, y)
6) get_patch_single.m - To get a 4 blocks around pixel (x, y)
7) SNR.m - SNR metric for comparisons
8) report.pdf - Report of observations

## Run the code:

To run the code type "block_filter" in the MATLAB terminal. 
If you want to run it for your custom US image, enter the path of the image in Line 3 of block_filter.m.


Results and observations are mentioned in the report.


## References for code:
[1] : https://www.mathworks.com/matlabcentral/fileexchange/27395-fast-non-local-means-1d--2d-color-and-3d
For NL Means filtering

[2] : https://www.mathworks.com/matlabcentral/fileexchange/54044-image-despeckle-filtering-toolbox?focused=5709989&tab=function
Image DeSpeckle Toolbox for Kuan, Lee and Frost filters

