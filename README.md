Getting & Clearing Data Course Project
======================================

Created by M. Louie


Introduction
------------

The goal of this script is to organize and select a subset of data collected from the accelerators from the Samsung Galaxy S smartphone. Only the mean and standard deviation are taken from the accelerators measurements.  

The script will write two file to the working directory:

+ Mean_SD_bySubActMeas.txt
+ Mean_SD_Average_bySubActMeas.txt


The first of these files, `Mean_SD_bySubActMeas.txt`, gives the mean and standard deviations for each individual measured event. The second of these, `Mean_SD_Average_bySubActMeas.txt`, gives the average of
all of the the measured events for a subject doing a specific activity.


The data for this project can be found at: 

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 


Running the script
------------------

The data for this project should be downloaded and unzipped. The folder contained the data should be place in the working directory with the `run_analysis.R` script. The following commands should be issues in R to gain the final tidy data sets required.


```
source('run_analysis.R')
run_analysis()
```

Nuts & bolts 
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


About the data
--------------

See:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

for more information on this data set.

