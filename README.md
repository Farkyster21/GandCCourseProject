GandCCourseProject
==================

Coursera: Getting and Cleaning Data Course Project

This project grabs data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Since the directions says, it should work as long as the data set is within your working directory, the "run_analysis.R" file doesn't include the download.file R Code. 
Assumes "data.zip" is the name of the zip file downloaded.

Pulls in the only the following files from the Zip File for Analysis:
For categorization value:
- 'features.txt': List of all features, which will be the column headers for the train and test datasets
- 'activity_labels.txt': Links the numerical labels in the "y" files with their activity names


Files Needed for the Training Data Set:
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels : Activity Numerical labels, range 1 to 6
- 'train/subject_train.txt': Subject labels: 30 Possible Subjects

File Needed for the Test Data set:
- 'test/X_test.txt': Test set
- 'test/y_test.txt': Test labels: Activity Numerical labels, range 1 to 6
- 'test/subject_test': Subject labels: 30 Possible Subjects


Step 1: Merging the Data
<ol/>
<li/> <p/> 1. Combined the train </p>  </li>
<li/> <p/> 2. Combined the test datas </p></li>
<li/> <p/> 3. Added the column names corresponding to the values in the features.txt and added "subject" and "activity" columns </p></li>
</ol>

Step 2: Extracting only the measurements that have mean and std
1. Extracted only the values with "mean()" and "std()" because they are the only true "means" and "stds"
2. Kept the "subject" and "activity" columns because they were relevant in the big picture for step 5

Step 3: Using descriptive activity names to name the activities
1. Using the activity_labels.txt to determine what each activity number stood for
2. Used gsubs to substitute out the number with the correct activity name

Step 4: Appropriately label the dat set with descriptive variable names
1. Felt the "features" column names were appropriate enough, but to adhere to the tidy data rules
2. Changed "X/Y/X" to X/Y/Z Direction, to represent the value in that axis direction
3. Eliminated the "()" such that there were no symbols in the variable names
4. Eliminated the "-" such that there were no symbols in the variable names
5. Changed "mean" to "MEAN" in order to try and provide some word separation in the variable name
6. Changed "std" to "StdDev" in order to try and provide some word separation in the variable name

Step 5: Creating a separate data set that gets the average of each variable/column, for each activity and subject
1. Used the dplyr package functions: group_by and summarise_each()
2. Tidy Data is within the variable "tidyData"





