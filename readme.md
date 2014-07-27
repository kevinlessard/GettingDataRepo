**Description**

30 subjects performed six activities wearing a smartphone. Data was collected on the 3-axial linear acceleration and angular velocity. The 30 subjects were placed in 2 sets, a train group and a test group.

For full description of the data…

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

To get the raw data…

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**Files**

1. readme.md 
2. codebook.md - description the variables and steps taken to transform the raw data
3. run\_analysis.r - the script to complete the transformation
4. finalTidyDataset.txt - final output file

**Instructions for Script**

1. Create a folder within your working directory called data
2. Download the raw data from the link above into your data folder
3. Install the reshape2 package into R
4. Execute the run\_analysis script

**Overview of steps occurring within the run\_analysis script**

1. Read in files for feature, activity labels, subjectID, activityID and measurement data for both the train and test datasets

2. Renamed the columns in the train and test datasets to the appropriate feature names from the features.txt file

3. Subsetted each dataset to only include column measurements that included a mean "mean()" or standard deviation "std()" measurement

4. Combined the subjectID, activityID and the subsetted data together using cbind for the train and the test datasets

5. Combined the newly created datasets to gather to create one master dataset

6. Cleaned up the column names by removing unneeded values

7. Matched the activity name to the activity ID and added activity name to the dataset

8. Re-ordered the dataset to a cleaner layout and removed unneeded columns to create the main "Tidy" dataset

9. Reshaped the Tidy dataset to create a new Tidy set with averages of the mean and std by subject and activity

10. exported this final table out to a text file.
