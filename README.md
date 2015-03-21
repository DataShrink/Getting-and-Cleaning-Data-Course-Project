# Course Project: making a tidy dataset #

## Introduction ##
In this repo, you will find three files: an R script named run_analysis.R, a code book describing the variables and this README.md file. If you are one of my markers, you will have found my .txt file on the Coursera Course Project site. This is quite a messy .txt, but there is actually a tidy data set there, just load it into R using the following commands: <br>> tidydata<-read.table("./data.txt", header=TRUE)
> View(tidydata) </br>

## The code: run_analysis.R
To run this code, you need to install the dplyr package. I haven't put this in my code because I figured you as a student in this course will probably have the dplyr packaged installed.

I will walk you through my function:
In the first step, the zip-file from the website is downloaded into a temporary file, and this temporary file gets unzipped and stored in a variable called 'alldata'. The temporary file gets deleted by the unlink function. The 'alldata' variable is a list of files containing the required info, mostly .txt files. I stored the files I would need to create my tidy data set in variables, I decided to store all of them as data frames by calling read.table on the index of the list I wanted to store. I created the variables 'activitynames' (in which the factor numbers and names of the activities are stored), 'features' in which all the variablenames are stored, testsubjects, in which the identifier numbers of all the subjects for every observation are stored, 'testset' for all the observations in the test set, 'testlabels' for the activity labels for all observations in the test set, and 'trainsubjects', 'trainset' and 'trainlabels' for the train set and its subject identifiers and labels.
Before merging 'trainset' and 'testset', I decided to add the 'activity' variable and 'id' variable to both sets. After that, I merged both sets using the merge() function, and stored the result in 'data'. Because these were all different observations I had to add all.x=TRUE and all.y=TRUE. After merging, I stored the variablenames in a character string called 'variablenames' and extracted only the names which had "mean()" as an exact value or "std" in the string, using the grep function, and stored their index numbers in 'exact'. I updated 'data' by just including the columns of the indeces stored in 'exact' and the newly made id and activity columns. I labeled the dimnames of data after that, and changed the numbered activity labels to activity names. While writing this, I am thinking I should have used dplyr here, but this seemed to work just fine at the time. The first tidy data set is created! Now, a new set has to be created, with averages for each variable for each activity and each subject.
I grouped the data by first activity and then id, storing the result in 'averagedata'. After that, I used the function summarise_each, to calculate the means of each activity for each subject. This is the second tidy data set. I wrote this in a .txt file and just to be helpful, also wrote the code to read the txt file back into a neat table in R.
This ended up with a tidy data set of 68 variables and 180 rows.

## The code book
To describe the study design and variables, I copied much of the original README file. 

Thanks for reading this, I look forward to your comments!  
