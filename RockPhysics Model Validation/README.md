# Model Prediction Analysis

# Background
This analysis aims to determine if the RockPhysics inversion algorithms can predict volumetric water content(VWC) in the soil using porosity(phi) and water saturation(Sw) parameters from the inversion result. 

Relationship between parameters
modeled VWC = phi * Sw

I use directly measured VWC content to compare to the modeled VWC to see if the model accurately predicts VWC in the soil.

# The Dataset
I looked at the change in VWC (delta VWC) between months to determine if the model matches the measured change. 

    - positive deltaVWC = soil got more wet
    - negative deltaVWC = soil got drier

This dataset shows the changes in VWC between May to August 2017 in a mountianous area of Wyoming. I expected to see a drying trend from May to August due to spring snowmelt peaking in May with minimal new precipitiation in those months. 

I gathered, cleaned, and exported the data as an Excel File

![table](https://github.com/nsmeltz/Portfolio/blob/fb3a680b86c0338aa97ccda210267f84a94c31a5/Model_Validation_Matlab/Images/table.jpg)

# Results 
I plotted the Measured Delta VWC vs RockPhysics Delta VWC for each measurement date
![plot](https://github.com/nsmeltz/Portfolio/blob/7a854025f84c72054b935a09d6856a985bb23c48/RockPhysics%20Model%20Validation/Images/plot.jpg)

The blue line is the linear regression of the data points
The red line is the y=x line (ie NMR Delta VWC = RockPhysics Delta VWC)

# Analysis
On initial inspection of the data it looks like there is a strong linear trend, but this is not what I wanted to evaluate with this dataset. I want to know if the RockPhysics modeling accurately predicts deltaVWC by comparing it to the measured deltaVWC. If the RockPhysics modeling did predict what the measured deltaVWC was then it would lie along the red line. The RockPhysics model predicts less negative VWC (ie the model predicts more drying of the soils than the measured data) which is not ideal if you wanted to use this data to discuss water storage in the ground through out the summer season. 

# Conclusion
In conclusion, the RockPhysics inversion algorithms need to be altered to better predict deltaVWC in the ground. It is possible that the RockPhysics algorithms need to be optimized for the type of soil/ground/geology in the area that the data was collected in.
