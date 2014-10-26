#####Given you downloaded the file from:url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
###Gave the zip file the name "data.zip" in your main directory

##Extracting all of the filenames and their paths within the "data.zip" file
td = tempdir()
fileNames <- unzip("data.zip", exdir = td, overwrite = TRUE)
fileNames

##All stored under fileNames. Breakdown of the filepaths needed beow with the corresponding files and path entry: 
#Entry: 14 is subject_test.txt
#Entry: 15 is x_test.txt
#Entry: 16 is y_test.txt
#Entry: 26 is subject_train.txt
#Entry: 27 is x_train.txt
#Entry: 28 is ytrain.txt
#Entry: 1 is activity labels
#Entry: 2 is features.txt


##Reading in each necessary file from the Filenames Path Vector established above
##Reading in Relevant Test Data
subj_test <- read.table(fileNames[14]) #dim = 2947, 1 ##Who completed the activity for each window sample: 1:30
x_test <- read.table(fileNames[15]) #dim = 2947, 561; Test set
y_test <- read.table(fileNames[16]) #dim = 2947, 1; Test Labels

##Reading in Relevant Train Data
subj_train <- read.table(fileNames[26]) #dim = 7352, 1 #Who completed the activity for the window sample: 1:30
x_train <- read.table(fileNames[27]) #dim = 7352, 561 ; Test Set
y_train <- read.table(fileNames[28]) #dim = 7352, 561 ; Training Labels

##Reading in Categorization Files
activity <- read.table(fileNames[1]) ##dim = 6, 2;Link the class labels with activity names
features <- read.table(fileNames[2]) ##dim = 561, 2; List of all the features


#####Step 1: Merging the Train and Test Data Sets
library(dplyr)
library(plyr)


#Combining all of the training data
train <- cbind(x_train,subj_train)
train <- cbind(train, y_train)

#Combining all of the test data
test <- cbind(x_test,subj_test)
test <- cbind(test,y_test)

#Combining the test and train data
dataSet <- rbind(train,test)

#Naming the columns with it's corresponding features from the features file, and added "subject" and "activity" columns
features_names <- as.character(features$V2)
features_names <- append(features_names,"subject")
features_names <- append(features_names,"activity")
names(dataSet) <- features_names


#####Step 2: Extracting only the measure ments that have meand and std deviation
dataMeanandStd <- dataSet[,grepl("mean()",features_names)&!grepl("Freq",features_names)|grepl("std()",features_names)|grepl("subject",features_names)|grepl("activity",features_names)]


#####Step 3: Uses descriptive activity names to name the activities in the dataSet
dataMeanandStd$activity <- gsub(1,"WALKING",dataMeanandStd$activity)
dataMeanandStd$activity <- gsub(2,"WALKING_UPSTAIRS",dataMeanandStd$activity)
dataMeanandStd$activity <- gsub(3,"WALKING_DOWNSTAIRS",dataMeanandStd$activity)
dataMeanandStd$activity <- gsub(4,"SITTING",dataMeanandStd$activity)
dataMeanandStd$activity <- gsub(5,"STANDING",dataMeanandStd$activity)
dataMeanandStd$activity <- gsub(6,"LAYING",dataMeanandStd$activity)


#####Step 4: Appropriately labels the data set with descriptive variable names
##Changed XYZ to specify they were directions
##Eliminated "-" and "()"
##Capitalized "mean" to "MEAN" and changed "std" to "StdDev" for word separation
names(dataMeanandStd) <- gsub("-X","XDirection",names(dataMeanandStd))
names(dataMeanandStd) <- gsub("-Y","YDirection",names(dataMeanandStd))
names(dataMeanandStd) <- gsub("-Z","ZDirection",names(dataMeanandStd))
names(dataMeanandStd) <- gsub("[:):]","",names(dataMeanandStd))
names(dataMeanandStd) <- gsub("[:(:]","",names(dataMeanandStd))
names(dataMeanandStd) <- gsub("-mean","MEAN",names(dataMeanandStd))
names(dataMeanandStd) <- gsub("-std","StdDev",names(dataMeanandStd))


#####Step 5: From data set in step 4, creates a second, independent tidy data set with the 
###average of each variable for each activity and each subject
tidyData <- group_by(dataMeanandStd,activity, subject)
tidyData <- summarise_each(tidyData,funs(mean))
