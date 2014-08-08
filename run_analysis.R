run_analysis <- function(){
  
  #Load useful packages
  library(reshape2)
  
  
  # Using https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  # With the file organizations such that the current working directory contains the file the directory "UCI HAR Dataset"

  print("Reading in raw data ...")
  
  #Load label information
  feat <- read.table("UCI\ HAR\ Dataset/features.txt", col.names=c('feat_id','Feature'))
  actinfo <- read.table("UCI\ HAR\ Dataset/activity_labels.txt", col.names=c('act_id', 'Activity'))
  
  
  #Load the training data
  train_x <- "data/UCI\ HAR\ Dataset/train/X_train.txt"
  train_sub <- "data/UCI\ HAR\ Dataset/train/subject_train.txt"
  train_y <- "data/UCI\ HAR\ Dataset/train/y_train.txt"
  xtrain <- read.table(train_x, col.names=feat$Feature)
  ytrain <- read.table(train_y, col.names="Activity")  # activity label
  subtrain <- read.table(train_sub, col.names="Subject")
  
  
  # Load the test data
  test_x <- "data/UCI\ HAR\ Dataset/test/X_test.txt"
  test_y <- "data/UCI\ HAR\ Dataset/test/y_test.txt"
  test_sub <- "data/UCI\ HAR\ Dataset/test/subject_test.txt"
  xtest <- read.table(test_x, col.names=feat$Feature)
  ytest <- read.table(test_y, col.names="Activity")  #activity label
  subtest <- read.table(test_sub, col.names="Subject")
  
  print("... complete")
  
  # Appends the activity value to the end of main dataset
  train <- cbind(ytrain,subtrain,xtrain)
  test <- cbind(ytest,subtest,xtest)
  
  #Merges the training and the test sets to create one data set. (DO WE NEED TO LABEL THESE SEPERATELY?, no bc subjects are independent)
  
  print("Merging training and test data sets...")
  complete <- rbind(train,test)
  print("...complete")
  
  #Extracts only the measurements on the mean and standard deviation for each measurement 
  
  print("Extacting mean and standard deviation values...")
  
  splitfeat = strsplit(names(complete),"\\.") 
  meanstd <- sort(as.numeric(c(grep("std",splitfeat),grep("mean",splitfeat))))
  mean <- sort(as.numeric(grep("mean",splitfeat)))
  std <- sort(as.numeric(grep("std",splitfeat)))
  meanfreq <- grep("meanFreq",splitfeat)
  mean <- mean[! mean %in% meanfreq]
  meanstd <- meanstd[! meanstd %in% meanfreq]
  
  print("... complete")
  
  #Uses decriptive activity names to name the activities in the data set 
  #  replacing the number of activity by the name from activity file
  
  print("Applying activity names")
  
  for (i in c(1:6)) {
    complete$Activity[complete$Activity == i] <- paste(actinfo$Activity[i])
  }
  
  mscomplete <- complete[,c(1,2,meanstd)]
  mcomplete<-complete[,c(1,2,mean)]
  scomplete<- complete[,c(1,2,std)]
  print("... complete")
  
  # Appropriately labels the data set with descriptive variable names
  
  print("Naming descriptive variables...")
  
  names(scomplete)[3:35] <- substring(names(scomplete)[3:35],2)
  names(mcomplete)[3:35] <- substring(names(mscomplete)[3:35],2)
  
  names(mcomplete) <- gsub("\\.1",'',gsub("\\.",'', gsub("\\.std\\.\\.",' ', gsub("\\.mean\\.\\.",' ', names(mcomplete)))))
  names(scomplete) <- gsub("\\.1",'',gsub("\\.",'', gsub("\\.std\\.\\.",' ', gsub("\\.mean\\.\\.",' ', names(scomplete)))))
  
  print("... complete")
  #Output file
  print("Writing output tidy data...")
  
  meantmp <-  melt(mcomplete, id.var=c("Activity", "Subject"), variable.name="Measurement", value.name="Mean")
  stdtmp <- melt(scomplete, id.var=c("Activity", "Subject"), variable.name="Measurement", value.name="Standard Deviation")

  vas_tmp <- merge(meantmp,stdtmp, by=c("Activity","Subject","Measurement"), all=TRUE)  
  vas_tmp <- vas_tmp[c(2,1,3,4,5)]
  
  
  write.table(vas_tmp,file="Mean_SD_bySubActMeas.txt", sep=";", col.names=TRUE, row.names=FALSE)
  
  
  
  print("... complete")
  
  
  # Create a second, independent tidy data set with the average of each variable for each activity and each subject.
  print("Creating second, independent tidy set with averages for each variable & activity...")
  
  varactsubmean <- mcomplete[1,]
  varactsubmean <-varactsubmean[-1,]
  varactsubstd <- scomplete[1,]
  varactsubstd <- varactsubstd[-1,]
  #create empty df
  for (x in sort(unique(mcomplete$Subject))) {
    tmpmeansub <- mcomplete[mcomplete$Subject == x,]
    tmpmean <- aggregate(tmpmeansub[,2:35], tmpmeansub['Activity'], function(x) mean(x,na.rm=T))
    varactsubmean <- rbind(varactsubmean,tmpmean)
    tmpstdsub <- scomplete[scomplete$Subject == x,]
    tmpstd <- aggregate(tmpstdsub[,2:35], tmpstdsub['Activity'], function(x) mean(x,na.rm=T))
    varactsubstd <- rbind(varactsubstd,tmpstd)
  }  
  
  names(varactsubmean) <- names(mcomplete)
  names(varactsubstd) <- names(scomplete)
  
  
  meantmp <-  melt(varactsubmean, id.var=c("Activity", "Subject"), variable.name="Measurement", value.name="Mean")
  stdtmp <- melt(varactsubstd, id.var=c("Activity", "Subject"), variable.name="Measurement", value.name="Standard Deviation")
  
  vas <- merge(meantmp,stdtmp,by=c("Activity","Subject","Measurement"), all=TRUE)
  vas <- vas[c(2,1,3,4,5)]
  
  write.table(vas,file="Mean_SD_Average_bySubActMeas.txt", sep=";", col.names=TRUE, row.names=FALSE)
  
  print("... complete")
  
  
  return(  print("Task completed") )
 #final data frame
}