
CodeBook 
========

Introduction
------------

This codebook corresponds to the Getting & Clearing Data Course Project which consists of:

+ README.md 
+ run_analysis.R 
+ CodeBook.md

The data for this project can be found at: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. Please read README.md for how script should be executed and what the directory structure for the rawdata should be to run the script.

After the 'run_analysis.R' script is ran the following two files are created:

+ Mean_SD_bySubActMeas.txt
+ Mean_SD_Average_bySubActMeas.txt


The purpose of this document is to describes the variables, the data, and any transformations or work performed to clean up the data. 


Nuts & Bolts 
------------

1. The three files corresponding to each subset, test and train, are loaded into R. 
    
  + X_[train/test].txt
  + Y_[train/test].txt
  + subject_[train/test].txt
    
  In addition, 'features.txt' and 'activity_label.txt' files are loaded. The features defined the first of   these files are used as the header names for the X_[Train/Test] files. 



2.  Once the data has been loaded into R, the X, Y, and subject dataframes are combined into a single data frame. Then, the train data frame are merged with the test data set. This data frame represents the complete sample with subject number and activity label. 


3. In this case, we are only interested in the measurement mean and standard deviation for the measurements. This data is extracted from the original data frame. 

4. The activity label is adjust from a numeric representation to the label given in the activity label data frame. 

5. Next the naming convention for the measurement data is adjust for clarity and to be able to link common measurements with both a mean and standard deviation value.  

6. A tidy data set is output such that each entry in this table gives the mean and/or standard deviation for a specific measurement, for a specific activity, for a specific subject. This data set has the following columns:
  + Subject Number
  + Activity
  + Measurement
  + Mean Value of Measurement
  + Standard Deviation of Measurement

  This data set is written out as 'Mean_SD_bySubActMeas.txt' to your working directory.


7. Finally, a second tidy data set is produced which lists the averages of the mean and/or standard deviation over each activity, for a specific measurement, for a specific subject. This data set has the same columns as the previous data set. 

  This data set is written out as 'Mean_SD_Average_bySubActMeas.txt' to your working directory. 


