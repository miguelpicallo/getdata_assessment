CodeBook for assessment
========================================================

# Raw Data Used:

The data used for this assessment consist of the accelerometers' gyroscopes' data of a Samsung Galaxy S smartphone. Using a group of 30 people within 19 to 48 years carrying the smartphone, data was recorded while they were perfoming 6 different actions: walking, walking upstairs, walking downstairs, sitting, standing and laying.

## Raw Data Files:

- *X_train.txt*: contains variables for the train set
- *y_train.txt*: contains labels for the train set
- *X_test.txt*: contains variables for the test set
- *y_test.txt*: contains labels for the test set
- *subject_train.txt*: IDs of subjects in train
- *subject_test.txt*: IDs of subjects in test
- *features.txt*: names of features, indicating the measurement
- *activity_labels.txt*: names of each of the activities corresponding to the label


# Objective:

The objective of the script *run_analysis.R* is to build a new tidy data set from the raw data files in several steps:


1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Steps:

- Set working directory:

```r
setwd("C:/Users/miguel/Documents/coursera/getting & cleaning Data")
```


- Load data  (data has to be in file *getdata-projectfiles-UCI HAR Dataset*):

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train = read.table(file)
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test = read.table(file)
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
trainLabel = read.table(file)
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
testLabel = read.table(file)
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
namesFeatures = read.table(file)
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
namesActivities = read.table(file)
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
trainSubj = read.table(file)
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
testSubj = read.table(file)
```


- Merge train-test and add labels:

```r
data = rbind(cbind(train, trainLabel), cbind(test, testLabel))
names(data)[ncol(data)] = "activity"
names(data)[1:(ncol(data) - 1)] = as.character(namesFeatures[, 2])
```


Show the number of rows for train, test and whole data:

```r
nrow(train)
```

```
## [1] 7352
```

```r
nrow(test)
```

```
## [1] 2947
```

```r
nrow(data)
```

```
## [1] 10299
```


- Extract only means and std:

```r
data = cbind(data[, which((grepl("mean", names(data)) | grepl("std", names(data))) & 
    !(grepl("meanFreq", names(data))))], data[, ncol(data)])
names(data)[ncol(data)] = "activity"
```


Show the names of the columns:

```r
names(data)
```

```
##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
##  [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
##  [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
## [11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
## [15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
## [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
## [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
## [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
## [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
## [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
## [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
## [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
## [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
## [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
## [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
## [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
## [63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 
## [67] "activity"
```


- Name the activities with descriptive activity names:

```r
namesActivities = as.character(namesActivities[, 2])
data$activity = as.factor(namesActivities[data$activity])
```


Show new names for activities:

```r
namesActivities
```

```
## [1] "WALKING"            "WALKING_UPSTAIRS"   "WALKING_DOWNSTAIRS"
## [4] "SITTING"            "STANDING"           "LAYING"
```


- Tidy set with means for each subject and activity: 

```r
# assign IDs
data2 = cbind(rbind(trainSubj, testSubj), data)
names(data2)[1] = "SubjectID"
data2[, 1] = as.factor(data2[, 1])

# means for subject and activity
data3 = as.data.frame(cbind(1:30, tapply(data2[, 2], data2[, 1], FUN = mean)))
for (i in 3:(ncol(data2) - 1)) {
    data3 = cbind(data3, tapply(data2[, i], data2[, 1], FUN = mean))
}
names(data3) = names(data2)[-ncol(data2)]
```


Show number of rows of data to see that is has been shorten because now it only has means:

```r
nrow(data3)
```

```
## [1] 30
```

