# 3D Plotting in Matlab

# Background
This work is a part of the analysis I did for my thesis research in Yellowstone National Park. For this analysis I will demonstrate how I filtered out datapoints prior to geophysical inversion and plotting the 5 lines of data in 3D space. 

# The Dataset
My [Processing_Workflow](https://github.com/nsmeltz/Portfolio/blob/c6286de401d14d99a8e43b349c75fa2fa365d7a1/3D_Plotting_Matlab/Processing_Workflow.pptx) powerpoint shows the step by step process that I used to determine what data I needed to filter out to produce a robust geophysical inverisons for each resistivity line shown in the image below.
![location](https://github.com/nsmeltz/Portfolio/blob/12554d19984b1631f0af69767d5d669b5e7e2359/3D_Plotting_Matlab/Images/GE_lines.jpg).                              
I wrote the [Histogram_Analysis](https://github.com/nsmeltz/Portfolio/blob/5d112a6feae2a677e499fa393df0d06c5cee5071/3D_Plotting_Matlab/Histogram_Analysis.m) script to plot a histogram of all measured values in the dataset (apparent resistivity RhoA) and filter the dataset based on the histogram binning. I exported the filterd datasets to use as the input to the geophysical inversion software. After completing the inversion process I exported the inversion results as text files (data1,data2,etc). Finally, I wrote the [Plot_3D](https://github.com/nsmeltz/Portfolio/blob/b673fa2bb33fbfb285dd71ec9c3d548f5b0105e2/3D_Plotting_Matlab/Plot_3D.m) to plot each resistivity line's data in 3D space.

![3D_Plot](https://github.com/nsmeltz/Portfolio/blob/b673fa2bb33fbfb285dd71ec9c3d548f5b0105e2/3D_Plotting_Matlab/Images/3D_plot.png)
