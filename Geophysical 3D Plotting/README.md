# 3D Plotting in Matlab

## Summary
This work is a part of the analysis I did for my thesis research in Yellowstone National Park. For this analysis I will walk through the step by step process that I used to determine what data I needed to filter out to produce a robust geophysical inverisons for each resistivity line shown in the image below.  

## Background: What is Geophysics?
Geophysics measures the physical properties of the Earth to determine where there is hard rock vs soft rock, water sataturated rock vs dry rock, and even magnetic rocks! In this analysis I used a type of geophysics called Electrical Resistivity. You can think the resistivity measurement like an xray for the Earth that can find where water is underground because water conducts electricity very well. Hot water that is rich in dissolved salts, like the water in Yellowstone, is particularly good at conducting electricity so it is easy to spot in resisvity datasets because it will show up as very low resistivity (ie high conductivity).

## The Dataset
![location](https://github.com/nsmeltz/Portfolio/blob/e0854428d17b28c55d054287d20d37b9beadd2d0/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/GE_lines.jpg).
   - 5 resistivity datasets were collected in parallel lines crossing over Rosette Spring
   - Each line is ~110m long 

Think of each one of these lines like a slice through the Earth. Each of the following image is looking at each line from "side view" which shows the relationship between depth into the Earth (y axis) and distance along the line (x axis).

## 1. Unfiltered Data Plot
This plot shows the data points as black dots with squares color coded by apparent resistivity values (RhoA). X axis is distance along the line, y axis is elevation, and  apparent resistivity is on a log10 scale (ie 0 is 10^0, 1 is 10^1, etc).
![pseudosection](https://github.com/nsmeltz/Portfolio/blob/2caf45f5f5f814df68e37868dd720ea45b248872/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/pseudosection.png)

## 2. Geophysical Inversion Result from Unfiltered Data
This plot shows what the geophysical inverison result looks like after I processed the unfiltered data. During the geophysical inversion the image above is converted from apparent resistivity (rhoA) to true resistivity(phi). It takes into account depth from the surface and temperature which is very important in a place like Yellowstone where the underground temperature increases by ~
![unfilteredResult](https://github.com/nsmeltz/Portfolio/blob/dca451f7393b933c777934e704c81ae98d16979e/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/unfiltered_geophys.png)

   - Final RMS on this inversion result was 1.17 implying that the geophysical model overfit the data set. Also visually this image is not "smooth" meaning that there is not a gradual transition between areas of high resistivity (red) and those with low resistivity (blue). For these reasons I decided to look at the raw unfiltered data more closely. 

## 3. Histogram showing the distribution of resistance values (RhoA) prior to filtering
I wrote the [Histogram_Analysis](https://github.com/nsmeltz/Portfolio/blob/5d112a6feae2a677e499fa393df0d06c5cee5071/3D_Plotting_Matlab/Histogram_Analysis.m) script to plot a histogram of all measured values in the dataset (apparent resistivity RhoA).
![histogram](https://github.com/nsmeltz/Portfolio/blob/bb296f85999c460003fb8d256d461cbf91964283/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/histogram.png)

   - The histrogram clearly shows a that the vast majority of the data points are in the 0 <= RhoA < 100 range.
   - I then exported a filtered dataset keeping only data points with 0 <= RhoA < 100

## 4. Filtered Data Plot
This plot shows all the data points as black dots with the FILTERED datapoints as squares color coded by apparent resistivity values (RhoA). Areas with black dots and no colored squares are where there is no longer data due to filtering.
![pseudosection_filtered](https://github.com/nsmeltz/Portfolio/blob/2caf45f5f5f814df68e37868dd720ea45b248872/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/pseudosection_filtered.png)

## 5. Geophysical Inversion Result from Filtered Data
This plot shows what the geophysical inverison result looks like after I processed the filtered data.
![filteredResult](https://github.com/nsmeltz/Portfolio/blob/dca451f7393b933c777934e704c81ae98d16979e/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/filtered_geophys.png)
   - Final RMS on this inversion result was 1.0 implying that the geophysical model overfit the data set. Now there is a smoother transition between areas of high and low resistivy.

## 6. 3D Plot
After repeating the steps 1-5 for each line of data the filtered results were plotted 3D space to see relationships between the data planes and surface features
![3D_Plot](https://github.com/nsmeltz/Portfolio/blob/29a6d1c158f8d178d73a2c563551f31486bca696/3D%20Resistivity%20Data%20Analysis%20&%20Plotting/Images/3D_plot.png)
   - The darkest blue areas in lines R2 & R3 likely represent areas of hot water bubbling up through the rock to feed Rosette Spring 
