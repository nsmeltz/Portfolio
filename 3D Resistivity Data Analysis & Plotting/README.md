# 3D Plotting in Matlab

# Background
This work is a part of the analysis I did for my thesis research in Yellowstone National Park. For this analysis I will walk through the step by step process that I used to determine what data I needed to filter out to produce a robust geophysical inverisons for each resistivity line shown in the image below.                       
![location](https://github.com/nsmeltz/Portfolio/blob/e0854428d17b28c55d054287d20d37b9beadd2d0/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/GE_lines.jpg).   
   - 5 resistivity datasets were collected in parallel lines crossing over Rosette Spring
   - Each line is ~110m long 

Think of each one of these lines like a slice through the Earth. Each of the following image is looking at each line from "side view" which shows the relationship between depth into the Earth (y axis) and distance along the line (x axis).

## 1. Unfiltered Data Plot
This plot shows the data points as black dots with squares color coded by  apparent resistivity  values (RhoA). X axis is distance along the line, y axis is elevation, and  apparent resistivity is on a log10 scale (ie 0 is 10^0, 1 is 10^1, etc).
![pseudosection](https://github.com/nsmeltz/Portfolio/blob/2caf45f5f5f814df68e37868dd720ea45b248872/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/pseudosection.png)

## 2. Geophysical Inversion Result
This plot shows what the geophysical inverison result looks like after I processed the unfiltered data. During the geophysical inversion the image above is converted from apparent resistivity (rhoA) to true resistivity(phi). It takes into account depth from the surface and temperature which is very important in a place like Yellowstone where the ground increases
![unfilteredResult](https://github.com/nsmeltz/Portfolio/blob/dca451f7393b933c777934e704c81ae98d16979e/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/unfiltered_geophys.png)

   - Final RMS on this inversion result was 1.17 implying that the geophysical model overfit the data set. Also visually this image is not "smooth" meaning that there is not a gradual transition between areas of high resistivity (red) and those with low resistivity (blue). For these reasons I decided to look at the raw unfiltered data more closely. 

## 3. Histogram showing the distribution of resistance values (RhoA) prior to filtering
The histrogram clearly shows a that the vast majority of the data points are in the 0 <= RhoA < 100 range
![histogram](https://github.com/nsmeltz/Portfolio/blob/bb296f85999c460003fb8d256d461cbf91964283/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/histogram.png)






I wrote the [Histogram_Analysis](https://github.com/nsmeltz/Portfolio/blob/5d112a6feae2a677e499fa393df0d06c5cee5071/3D_Plotting_Matlab/Histogram_Analysis.m) script to plot a histogram of all measured values in the dataset (apparent resistivity RhoA) and filter the dataset based on the histogram binning. I exported the filterd datasets to use as the input to the geophysical inversion software. After completing the inversion process I exported the inversion results as text files (data1,data2,etc). Finally, I wrote the [Plot_3D](https://github.com/nsmeltz/Portfolio/blob/b673fa2bb33fbfb285dd71ec9c3d548f5b0105e2/3D_Plotting_Matlab/Plot_3D.m) to plot each resistivity line's data in 3D space.

![3D_Plot](https://github.com/nsmeltz/Portfolio/blob/b673fa2bb33fbfb285dd71ec9c3d548f5b0105e2/3D_Plotting_Matlab/Images/3D_plot.png)
