# GACD_courseassignment
Coursera Getting and Cleaning Data Course Assignment


Steps followed in R script:

First download the data and save it in work directory and Set work directory in R

Step1: Merges the training and the test sets to create one data set.

- read in the various test and training files
- merge the test and training files

Step2: Extracts only the measurements on the mean and standard deviation for each measurement. 

- read in the features file
- calculate mean and stdev
- formatting

Step3: Uses descriptive activity names to name the activities in the data set.

- read in the activity file
- name the activities

Step4 : Appropriately labels the data set with descriptive variable names.

- send output1 to text file

Step5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- calculate number of activity and subjects
- create blank matrix
- loop through for all activities and subjects, calculate average, populate matrix
- send output2 to text file
