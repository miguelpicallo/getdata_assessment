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
5- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Steps:

- Set working directory:

```r
setwd("C:/Users/miguel/Documents/coursera/getting & cleaning Data")
getwd()
```

```
## [1] "C:/Users/miguel/Documents/coursera/getting & cleaning Data"
```

```r
list.files(paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train"))
```

```
## [1] "Inertial Signals"  "subject_train.txt" "X_train.txt"      
## [4] "y_train.txt"
```


- Load data  (data has to be in file *getdata-projectfiles-UCI HAR Dataset*):

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/train/X_train.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/test/X_test.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
trainLabel = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/train/y_train.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
testLabel = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/test/y_test.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
namesFeatures = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/features.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
namesActivities = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/activity_labels.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
trainSubj = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/train/subject_train.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```

```r
file = paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
testSubj = read.table(file)
```

```
## Warning: no fue posible abrir el archivo
## 'C:/Users/miguel/Documents/coursera/getting & cleaning
## Data/getdata_assessment/getdata-projectfiles-UCI HAR Dataset/UCI HAR
## Dataset/test/subject_test.txt': No such file or directory
```

```
## Error: no se puede abrir la conexión
```


- Merge train-test and add labels:

```r
data = rbind(cbind(train, trainLabel), cbind(test, testLabel))
```

```
## Error: objeto 'train' no encontrado
```

```r
names(data)[ncol(data)] = "activity"
```

```
## Error: names() aplicado a un objeto que no es un vector
```

```r
names(data)[1:(ncol(data) - 1)] = as.character(namesFeatures[, 2])
```

```
## Error: objeto 'namesFeatures' no encontrado
```


- Extract only means and std:

```r
data = cbind(data[, which((grepl("mean", names(data)) | grepl("std", names(data))) & 
    !(grepl("meanFreq", names(data))))], data[, ncol(data)])
```

```
## Error: objeto de tipo 'closure' no es subconjunto
```

```r
names(data)[ncol(data)] = "activity"
```

```
## Error: names() aplicado a un objeto que no es un vector
```


- Name the activities with descriptive activity names:

```r
namesActivities = as.character(namesActivities[, 2])
```

```
## Error: objeto 'namesActivities' no encontrado
```

```r
data$activity = as.factor(namesActivities[data$activity])
```

```
## Error: objeto 'namesActivities' no encontrado
```


- Tidy set with means for each subject and activity: 

```r
# assign IDs
data2 = cbind(rbind(trainSubj, testSubj), data)
```

```
## Error: objeto 'trainSubj' no encontrado
```

```r
names(data2)[1] = "SubjectID"
```

```
## Error: objeto 'data2' no encontrado
```

```r
data2[, 1] = as.factor(data2[, 1])
```

```
## Error: objeto 'data2' no encontrado
```

```r

# means for subject and activity
data3 = as.data.frame(cbind(1:30, tapply(data2[, 2], data2[, 1], FUN = mean)))
```

```
## Error: objeto 'data2' no encontrado
```

```r
for (i in 3:(ncol(data2) - 1)) {
    data3 = cbind(data3, tapply(data2[, i], data2[, 1], FUN = mean))
}
```

```
## Error: objeto 'data2' no encontrado
```

```r
names(data3) = names(data2)[-ncol(data2)]
```

```
## Error: objeto 'data2' no encontrado
```

