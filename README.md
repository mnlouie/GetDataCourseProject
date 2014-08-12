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


About the data
--------------

See:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

for more information on this data set.

