# Loading required libraries for the assignement
library(knitr)
library(readtext)

#Downloading files
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = './data/Getting & cleaning data/Assignement.zip')

#Unzipping file
unzip('./data/Getting & cleaning data/Assignement.zip',exdir="./data/Getting & cleaning data/Assignement")

#Reading Text Activities & Features files
ActivityLabels<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, col.names=c("ActivityId","Activity"))
Features<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE,col.names=c("FeaturesId","Features"))

#Reading Training files
XTrain<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/train/X_train.txt",col.names=Features[,2])
YTrain<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/train/y_train.txt",col.names="ActivityId")
SubjectTrain<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/train/subject_train.txt", col.names="SubjectId")

#Reading Test files
XTest<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/test/X_test.txt",col.names=Features[,2])
YTest<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/test/y_test.txt",col.names="ActivityId")
SubjectTest<-read.table("./data/Getting & cleaning data/Assignement/UCI HAR Dataset/test/subject_test.txt", col.names="SubjectId")

#Merging Test and Training files into one dataset
DataBase<-rbind(XTrain,XTest)
ActivitiesMerge<-rbind(YTrain,YTest)
SubjectMerge<-rbind(SubjectTrain,SubjectTest)

#Extracting only mean and standard deviation measurements
Extract<-grep("[Mm]ean\\(\\)|[Ss]td\\(\\)",Features[,2])
DataBase<-DataBase[,Extract]

#Describing activity names and subjects
DataBase<-merge(ActivityLabels,cbind(SubjectsMerge,ActivitiesMerge,DataBase),by.x="ActivityId",by.y="ActivityId",all=TRUE)

#Getting average measurements per activities and subjects
TidyDataset<-aggregate(DataMerge[,4:89],list(DataMerge$Activity,DataMerge$SubjectId),mean)
names(TidyDataset)[1:2]<-c("Activities","Subject")

#Writing the tidy dataset in a csv and text files
write.csv(TidyDataset,file="./data/Getting & cleaning data/Assignement/TidyDataset.csv")
write.table(TidyDataset, file = "./data/Getting & cleaning data/Assignement/TidyDataset.txt", sep = ",", row.names = FALSE)
