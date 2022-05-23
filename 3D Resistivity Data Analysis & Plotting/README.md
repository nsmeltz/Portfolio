# 3D Plotting in Matlab

# Background
This work is a part of the analysis I did for my thesis research in Yellowstone National Park. For this analysis I will walk through the step by step process that I used to determine what data I needed to filter out to produce a robust geophysical inverisons for each resistivity line shown in the image below. 
![location](https://github.com/nsmeltz/Portfolio/blob/e0854428d17b28c55d054287d20d37b9beadd2d0/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/GE_lines.jpg).   
   - 5 resistivity datasets were collected in parallel lines crossing over Rosette Spring
   - Each line is ~110m long 

## 1. Plot Raw data Pseudosection
This plot shows the data points as black dots with squares color coded by resistance value. X axis is distance along the line, y axis is elevation, and resistance value is on a log10 scale (ie 0 is 10^0, 1 is 10^1, etc).
![pseudosection](https://github.com/nsmeltz/Portfolio/blob/bd1262b65bd193d11c5b344b5502d66c30ad8c7a/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/pseudosection.png)








I wrote the [Histogram_Analysis](https://github.com/nsmeltz/Portfolio/blob/5d112a6feae2a677e499fa393df0d06c5cee5071/3D_Plotting_Matlab/Histogram_Analysis.m) script to plot a histogram of all measured values in the dataset (apparent resistivity RhoA) and filter the dataset based on the histogram binning. I exported the filterd datasets to use as the input to the geophysical inversion software. After completing the inversion process I exported the inversion results as text files (data1,data2,etc). Finally, I wrote the [Plot_3D](https://github.com/nsmeltz/Portfolio/blob/b673fa2bb33fbfb285dd71ec9c3d548f5b0105e2/3D_Plotting_Matlab/Plot_3D.m) to plot each resistivity line's data in 3D space.

![3D_Plot](https://github.com/nsmeltz/Portfolio/blob/b673fa2bb33fbfb285dd71ec9c3d548f5b0105e2/3D_Plotting_Matlab/Images/3D_plot.png)
