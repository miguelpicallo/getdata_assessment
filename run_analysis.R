rm(list=ls())
gc()

# project

# 1. merge the data:

# load data
setwd('C:/Users/miguel.picallo.cruz/Documents/personal/coursera/getting & cleaning Data/')
setwd('C:/Users/miguel/Documents/coursera/getting & cleaning Data')

file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt')
train=read.table(file)
file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt')
test=read.table(file)
file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt')
trainLabel=read.table(file)
file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt')
testLabel=read.table(file)

file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt')
namesFeatures=read.table(file)

file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt')
namesActivities=read.table(file)

# load subjects IDs
file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt')
trainSubj=read.table(file)
file=paste0(getwd(),'/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt')
testSubj=read.table(file)

# merga data
data=rbind(cbind(train,trainLabel),cbind(test,testLabel))
names(data)[ncol(data)]='activity'
names(data)[1:(ncol(data)-1)]=as.character(namesFeatures[,2])

# 2. extract only means and std:
data=cbind(data[,which( (grepl('mean',names(data)) | grepl('std',names(data))) & 
                    !(grepl('meanFreq',names(data)) ))] , data[,ncol(data)])
names(data)[ncol(data)]='activity'

# 3. & 4 name the activities with descriptive activity names:

# load activity names
namesActivities=as.character(namesActivities[,2])

# assign activity names
data$activity=as.factor(namesActivities[data$activity])

# 5. second data set with means for each subject and activity:

# assign IDs
data2=cbind(rbind(trainSubj,testSubj),data)
names(data2)[1]='SubjectID'
data2[,1]=as.factor(data2[,1])

# means for subject and activity
data3=as.data.frame(cbind(1:30,tapply(data2[,2],data2[,1],FUN=mean)))
for (i in 3:(ncol(data2)-1)){
  data3=cbind(data3,tapply(data2[,i],data2[,1],FUN=mean))
}
names(data3)=names(data2)[-ncol(data2)]

# write table
write.table(data3,file='tidyData.txt',row.names=F,sep=',')
