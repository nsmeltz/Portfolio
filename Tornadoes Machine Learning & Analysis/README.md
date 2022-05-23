# Tornado Data Analysis

## The Dataset
     - Our group utilized the SPC National Severe Weather Database Browser to download severe weather data including tornadoes (since 1950), as well as hail and damaging winds data (since 1955). 
       - [https://www.spc.noaa.gov/climo/online/sp3/plot.php](https://www.spc.noaa.gov/climo/online/sp3/plot.php)
       - The data is derived from the National Weather Service's Storm Data publication, which is reviewed and processed by the National Climatic Data Center and the Storm Prediction Center

   - **Questions we hope to answer through data analysis:** 
   
     - Which tornado magnitude is the most common?

     - Which state has the most tornadoes?

     - In which month do the most tornadoes occur? 

     - Can we predict the number of fatalaties resulting from a tornado if we know the magnitude (EF rating) and population of the county? 

     - Can we determine if the location of "tornado alley" is changing over time? Or are there multiple "tornado alleys"? 
     
## Data Cleaning Process

- **Tornado Data:** 
  - Filtered out bad data (ie EF ratings not 0-5)
  - Filtered for lower 48 US states (exclude PR, VI, HI, AK)
  - Loss & Crop Loss: Filtered for data after 2016
  - Filtered for 2008-2020 (F scale/EF scale change) 

## Machine Learning Models

Prior to applying either model the dataset is accessed in the database via PySpark, then converted to a Pandas df, and data types are converted to appropriate. The dataset is assigne the input and output variable then split in to training and testing data. 

1. Determine tornado's EF score based on these metrics: number of injuries, number of fatalities, loss ($), crop loss($), length (mi), and width (yds)
   - **Random Forest**                                                                          
      We started with Random Forest which returned an accuracy of 0.55625. The group decided this was too low and used the feature imporance plot to determine which features were most significant in predicting EF rating so we could apply it to a logistic regression instead. 
![Feature Importance](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/RF_FeatureImportance.png)

      From this plot we determined that the Loss, Width, and Length were the top contributers to EF rating. 
       
   

   - **Logistic Regression**                                                                     
   Visualizing relationships between EF rating, Loss, Width, and Length
   
  EF vs Loss          |  EF vs Width          | EF vs Length
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/EF_Loss.png) |  ![](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/EF_Width.png) |  ![](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/EF_Length.png)  

![](https://github.com/adavisfoy/group_2_project/blob/3318ef4e601c313fa21271148c17238af183b965/ML/Final%20ML%20Models/Images/LogReg_accuracy.png)
The Logistic Regression returned slightly higher testing accuracy than the Random Forest Model. 
Training Accuracy          |  Testing Accuracy         
:-------------------------:|:-------------------------:
0.6436482631313979         | 0.6388119808708784

2. Determine number of fatalities based on these metrics: EF rating, number of injuries, length (mi), width(yds), and county population
   - **Neural Network**  
![](https://github.com/adavisfoy/group_2_project/blob/c6fb0a799a0bda436a2c5512b566d1d6e5f55538/ML/Final%20ML%20Models/Images/NN_model.png)

The Neural Network Model testing data returned Loss: 0.9574524760246277 and Accuracy: 0.9464285969734192. 94% accuracy is too high for real world data so we decided to look into the evolution of the accuracy as the model ran. The following graphs show the loss and accuracy through each iteration (epoch) of the model. This model quickly increases accuracy (~20epochs) and converges to ~95% testing accuracy. The testing accuracy is greater than the training accuracy suggesting that the model is underfitting the data. The loss graph also suggests underfitting because loss does not decrease with increasing epochs (ie the model was unable to learn the training dataset). Overall this model is not well fit to the complexity of this dataset.  
 Model Accuracy         |   Model Accuracy  
:-------------------------:|:-------------------------:
![](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/NN_accuracy.png) |  ![](https://github.com/adavisfoy/group_2_project/blob/20402cb68e114dadb272f1f0eaa03d847215ad3f/ML/Final%20ML%20Models/Images/NN_loss.png) | 


Summary: From our experience with these machine learning methods it seems that this dataset has very complicated patterns or the lack of patterns making it difficult to model. We think some of this may come from the fact that the vast majority of tornadoes in our dataset did not have any fatalities but one entry has 168 fatalites. This likely makes it very difficult to the machine learning algorithms to learn a pattern from this dataset. 

### Tableau Story

  - [Tableau Story](https://public.tableau.com/shared/4MXXXP5Q2?:display_count=n&:origin=viz_share_link)
