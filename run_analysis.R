
run_analysis <- function() {
  
  ## Storing the zip file in a temporary file, than unzipping it in 'alldata' variable
  temp<-tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
  alldata<-unzip(temp)
  unlink(temp)
  
  ## Creating variables for all the textfiles needed to make this tidy dataset
  activitynames<-read.table(alldata[1])
  features<-read.table(alldata[2])
  testsubjects<-read.table(alldata[14])
  testset<-read.table(alldata[15])
  testlabels<-read.table(alldata[16])
  trainsubjects<-read.table(alldata[26])
  trainset<-read.table(alldata[27])
  trainlabels<-read.table(alldata[28])
  
  ## Adding training label variable (activity) to both the training and test data set
  trainset$activity<-as.factor(trainlabels[,1])
  testset$activity<-as.factor(testlabels[,1])
  
  ## Adding id of subject variable (id) to both the training and test data set
  trainset$id<-as.numeric(trainsubjects[,1])
  testset$id<-as.numeric(testsubjects[,1])
  
  ## Merging both data sets
  data<-merge(trainset, testset, all.x=TRUE, all.y=TRUE)
  
  ## Extracting only the means and standard deviations
  variablenames<-as.character(features[,2])
  extract<-c(grep("mean()", variablenames, fixed=TRUE), grep("std",variablenames))
  data<-data[,c(extract,562,563)]
  
  ## labeling the variablenames
  dimnames(data)[[2]][1:66]<-variablenames[extract]
  
  ## Putting descriptive names to the activity variable
  data$activity<-ordered(data$activity, levels=c(1:6), labels=activitynames[,2])
  
  ## Creating an indepent, second data set with the average for each variable for each activity and each subject
  averagedata<-group_by(data,activity, id)
  averagedata<-summarise_each(averagedata, funs(mean))
  write.table(averagedata, file="./data.txt", row.names=FALSE)
  ## Getting it read into R in a readable way
  tidydata<-read.table("./data.txt", header=TRUE)
  View(tidydata)
}