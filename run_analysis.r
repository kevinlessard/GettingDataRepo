#Script to take raw data inputs from the UCI HAR Dataset and process it to a summarized dataset that displays
#average measurement values by subject and activity


# load reshape library
library (reshape2)

# load in data feature and activity names
features <- read.table("./data/UCI HAR Dataset/features.txt", sep = "")
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt", sep = "", col.names = c("activityID", "activityName"))

# load in subject, activity and measurement data for the train subgroup
trainDataSub <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", sep = "", col.name = "subjectID")
trainDataAct <- read.table("./data/UCI HAR Dataset/train/y_train.txt", sep = "", col.name = "activityID")
trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", sep = "")
# load in subject, activity and measurement data for the test subgroup
testDataSub <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", sep = "", col.name = "subjectID")
testDataAct <- read.table("./data/UCI HAR Dataset/test/y_test.txt", sep = "", col.name = "activityID")
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", sep = "")

# rename column headers to feature names
colnames(trainData) <- features[,2]
colnames(testData) <- features[,2]

# subset data to only include measures for mean and standard deviation
subTrainData <- trainData[, grep("mean()|std()", colnames(trainData))]
subTestData <- testData[, grep("mean()|std()", colnames(testData))]

# column bind the subjectID and activityID to the measurements for both subgroups 
trainDataMer <- cbind(trainDataSub, trainDataAct, subTrainData)
testDataMer <- cbind(testDataSub, testDataAct, subTestData)
# row bind the 2 subgroups into one master dataset
masterDataset <- rbind(trainDataMer, testDataMer)
# clean up the column names by removing unneeded characters
colnames(masterDataset) <- gsub("\\()","",names(masterDataset),)

# match the activityID to it's corresponding ActivityName
activityMatch <- match(masterDataset$activityID, activity$activityID)
masterDataset$activityName <- activity[activityMatch,2]

#reorder the master dataset to subjectID, activityName followed by the measurement values.  activityID is dropped
tidyMasterDataset <- masterDataset[,c(1,82,3:81)]

# melt the tidy master dataset and recombine to calculate the average measurement by subjectID and activityName
meltedData <- melt(tidyMasterDataset, id = c("subjectID", "activityName"), measures.vars = c(3:81))
finalTidyDataset <- dcast(meltedData, subjectID + activityName ~ variable,mean)

#write the final output to a txt file.
write.table(finalTidyDataset, "./data/finalTidyDataset.txt", sep="\t", row.names=FALSE)