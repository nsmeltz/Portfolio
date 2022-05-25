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

Goal: Determine tornado's EF score based on these metrics: number of injuries, number of fatalities, loss ($), crop loss($), length (mi), and width (yds)

**Random Forest**                                                                          
      I started with Random Forest which returned an accuracy of 0.63905. This accuracy is fairly good for the dataset I wanted to see if I could increase it by using another algorithm. I used the feature imporance plot to determine which features were most significant in predicting EF rating so I could apply it to a logistic regression and a neural network.
![Feature Importance](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/RF_FeatureImportance.png)

      From this plot I determined that the Loss, Width, and Length were the top contributers to EF rating. 
       
   

**Logistic Regression**                                                                     
   Visualizing relationships between EF rating, Loss, Width, and Length
   
  EF vs Loss          |  EF vs Width          | EF vs Length
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/EF_Loss.png) |  ![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/EF_Width.png) |  ![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/EF_Length.png)  

![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/LogReg_accuracy.png)
The Logistic Regression returned lower testing accuracy than the Random Forest Model, suggesting that it is not complex enough for this dataset.  
Training Accuracy          |  Testing Accuracy         
:-------------------------:|:-------------------------:
0.4861111111111111     | 0.48520710059171596

**Neural Network**  
![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/LogReg_accuracy.png/NN_model.png)

The Neural Network Model testing data returned Loss: 0.9877785444259644, Accuracy: 0.39053255319595337. 39% accuracy seemed low so I decided to look into the evolution of the accuracy as the model ran. The following graphs show the loss and accuracy through each iteration (epoch) of the model. This model immediately flatlines at ~39% accuracy after epoch 0 meaning suggesting underfitting and a possibly that the Adam optimization function does not fit this dataset. The testing accuracy is greater than the training accuracy suggesting that the model is underfitting the data. However, the loss decreases with increasing epochs implying that the model did learn from the training data. Overall this model is not well fit to the complexity of this dataset and is likely too simple for how complex the data is.  
 Model Accuracy         |   Model Accuracy  
:-------------------------:|:-------------------------:
![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/NN_accuracy.png) |  ![](https://github.com/nsmeltz/Portfolio/blob/5c53bb0b4cabfb33e6458df80fb07ec0b295e9fe/Tornadoes%20Machine%20Learning%20&%20Analysis/Images/NN_loss.png) | 


Summary: From my experience with these machine learning methods it seems that this dataset has either very complicated patterns or the lack of patterns making it difficult to model. The logistic regression was able to predict the data most accurately, but I would not consider this a viable model for predicting EF rating from number of fatalities, injuries, crop loss ($), loss ($), length (miles), & width (yards).

### Tableau Story

  - [Tableau Story](https://public.tableau.com/shared/4MXXXP5Q2?:display_count=n&:origin=viz_share_link)
