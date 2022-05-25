# Tornado Data Analysis

## The Dataset
     - I utilized the NOAA National Severe Weather Database Browser to download all tornado data from 1950-2020
  ![NOAA](https://github.com/nsmeltz/Portfolio/blob/fbf381a3d80497a336325ddfbe00080dadcfff01/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/NOAA_SPC.png)
  
## Questions I hope to answer through my analysis:
   
     - Which tornado magnitude is the most common?

     - Which state has the most tornadoes?

     - In which month do the most tornadoes occur? 

     - Can I predict the EF rating of a tornado given the number of fatalities, injuries, crop loss ($), loss ($), length (miles), & width (yards)? 

     - Can I determine if the location of "tornado alley" is changing over time? Or are there multiple "tornado alleys"? 
     
## Data Cleaning Process

Tornado Data Dictionary
| Column Name  	| Data Type 	| Description                 	|
|--------------	|-----------	|-----------------------------	|
| Timestamp    	| datetime  	| Date & Time                 	|
| Year         	| integer   	| Year from 2008 - 2020       	|
| Month        	| integer   	| Month of Year               	|
| Day          	| integer   	| Day of Month                	|
| State        	| string    	| State Tornado Started in    	|
| Start_Lat    	| float     	| Starting Latitude           	|
| Start_Lon    	| float     	| Starting longitude          	|
| End_Lat      	| float     	| Ending latitude             	|
| End_Lon      	| float     	| Ending longitude            	|
| EF           	| integer   	| EF Scale Rating (0-5)       	|
| Injuries     	| intger    	| No of injuries occured      	|
| Fatalities   	| integer   	| No of deaths occured        	|
| Loss         	| float     	| Estimated Property loss ($) 	|
| Crop_Loss    	| float     	| Estimated Crop Loss ($)     	|
| Length       	| float     	| Length in miles             	|
| Width        	| integer   	| Width in yards              	|


     - Filtered out bad data (ie EF ratings not 0-5)
     - Filtered for lower 48 US states (exclude PR, VI, HI, AK)
     - Loss & Crop Loss: 
          - adjusted so all entries were in whole number dollars
          - input NaN for entries with 0 becasue that does not mean $0 in damage, it means no data collected
     - Filtered for 2008-2020 (in late 2007 the scale for measuring tornadoes changed from the F scale to the EF scale)



## Machine Learning Models

1. Determine tornado's EF score based on these metrics: number of injuries, number of fatalities, loss ($), crop loss($), length (mi), and width (yds)
   - **Random Forest**                                                                          
      I started with Random Forest which returned an accuracy of 0.63905. This accuracy is fairly good for the dataset I wanted to see if I could increase it by using another algorithm. I used the feature imporance plot to determine which features were most significant in predicting EF rating so I could apply it to a logistic regression and a neural network.
![Feature Importance](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/RF_FeatureImportance.png)

      From this plot I determined that the Loss, Width, and Length were the top contributers to EF rating. 
       
   

   - **Logistic Regression**                                                                     
   Visualizing relationships between EF rating, Loss, Width, and Length
   
  EF vs Loss          |  EF vs Width          | EF vs Length
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/EF_Loss.png) |  ![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/EF_Width.png) |  ![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/EF_Length.png)  

![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/LogReg_accuracy.png)
The Logistic Regression returned slightly higher testing accuracy than the Random Forest Model. 
Training Accuracy          |  Testing Accuracy         
:-------------------------:|:-------------------------:
0.4861111111111111     | 0.48520710059171596

2. Determine number of fatalities based on these metrics: EF rating, number of injuries, length (mi), width(yds), and county population
   - **Neural Network**  
![](https://github.com/adavisfoy/group_2_project/blob/c6fb0a799a0bda436a2c5512b566d1d6e5f55538/ML/Final%20ML%20Models/Images/NN_model.png)

The Neural Network Model testing data returned Loss: 0.9574524760246277 and Accuracy: 0.9464285969734192. 94% accuracy is too high for real world data so I decided to look into the evolution of the accuracy as the model ran. The following graphs show the loss and accuracy through each iteration (epoch) of the model. This model quickly increases accuracy (~20epochs) and converges to ~95% testing accuracy. The testing accuracy is greater than the training accuracy suggesting that the model is underfitting the data. The loss graph also suggests underfitting because loss does not decrease with increasing epochs (ie the model was unable to learn the training dataset). Overall this model is not well fit to the complexity of this dataset.  
 Model Accuracy         |   Model Accuracy  
:-------------------------:|:-------------------------:
![](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/NN_accuracy.png) |  ![](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/NN_loss.png) | 


Summary: From my experience with these machine learning methods it seems that this dataset has either very complicated patterns or the lack of patterns making it difficult to model. I think some of this may come from the fact that the vast majority of tornadoes in our dataset did not have any fatalities, but one entry has 168 fatalites. This likely makes it very difficult to the machine learning algorithms to learn a pattern from this dataset. 

### Tableau Story

  - [Tableau Story](https://public.tableau.com/shared/4MXXXP5Q2?:display_count=n&:origin=viz_share_link)
