########################################
# COURSERA : GETTING AND CLEANING DATA #  
# Course Project                       #
########################################

### Set work directory
workdir<-"C:/Users/e038163/Desktop/Coursera/GACD_assgn/"
setwd(workdir)

### Step1: Merges the training and the test sets to create one data set.

# read in the various test and training files

trainData <- read.table("./X_train.txt")
trainLabel <- read.table("./y_train.txt")
trainSubject <- read.table("./subject_train.txt")

testData <- read.table("./X_test.txt")
testLabel <- read.table("./y_test.txt") 
testSubject <- read.table("./subject_test.txt")

# merge the test and training files

joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

### Step2: Extracts only the measurements on the mean and standard deviation for each measurement. 

# read in the features file

features <- read.table("./features.txt")

# calculate mean and stdev

meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, meanStdIndices]

# formatting

names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

### Step3: Uses descriptive activity names to name the activities in the data set.

# read in the activity file

activity <- read.table("./activity_labels.txt")

# name the activities

activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

### Step4 : Appropriately labels the data set with descriptive variable names.

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)

# output1 to text file

write.table(cleanedData, "merged_data.txt")

### Step5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# calculate number of activity and subjects

subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 

# create blank matrix

columnLen <- dim(cleanedData)[2]
TidyData <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
TidyData <- as.data.frame(TidyData)
colnames(TidyData) <- colnames(cleanedData)

# loop through for all activities and subjects, calculate average, populate matrix

row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    TidyData[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    TidyData[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    TidyData[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}

# output2 to text file

write.table(TidyData, "tidy_data.txt")

###############
# END OF CODE #
###############
