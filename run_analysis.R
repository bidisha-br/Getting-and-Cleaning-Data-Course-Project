library(dplyr)

# read training data
X_training <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
Y_training <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
Subj_training <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

# read testing data
X_testData <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
Y_testData <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
Subj_testData <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

# read the features description
feature_names <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")

# read the activity labels
activity_labels <- read.table("E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Step 1. Merging the training and the test sets to create one data set.
X_total <- rbind(X_training, X_testData)
Y_total <- rbind(Y_training, Y_testData)
Subj_total <- rbind(Subj_training, Subj_testData)

# Step 2. Extract only the measurements on the mean and standard deviation for each measurement.
selected_feature <- feature_names[grep("mean\\(\\)|std\\(\\)",feature_names[,2]),]
X_total <- X_total[,selected_feature[,1]]

# Step 3. Use descriptive activity name to name the activities in the data set
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_total[,-1]

# Step 4. Appropriately labels the data set with descriptive variable names.
colnames(X_total) <- feature_names[selected_feature[,1],2]

# Step 5. From the data set in step 4, create a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(Subj_total) <- "subject"
total <- cbind(X_total, activitylabel, Sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "E:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)

