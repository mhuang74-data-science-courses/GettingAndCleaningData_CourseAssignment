## For DEBUGGING: set MAX_ROWS to small positive value to make it easier to debug. Set to -1 to read in entire files.
MAX_ROWS <- -1

## dataset root directory
dataset_root <- "./UCI HAR Dataset/"

## training data files
filename_train_measurement <- paste(dataset_root, "train/", "X_train.txt", sep = "")
filename_train_activity <- paste(dataset_root, "train/", "y_train.txt", sep = "")
filename_train_subject <- paste(dataset_root, "train/", "subject_train.txt", sep = "")

## test data files
filename_test_measurement <- paste(dataset_root, "test/", "X_test.txt", sep = "")
filename_test_activity <- paste(dataset_root, "test/", "y_test.txt", sep = "")
filename_test_subject <- paste(dataset_root, "test/", "subject_test.txt", sep = "")

## labels
filename_labels_features <- paste(dataset_root, "features.txt", sep = "")
filename_labels_activity <- paste(dataset_root, "activity_labels.txt", sep = "")


## combine activity ids and join with activity label file

# load activity files
train_activity <- read.table(filename_train_activity, header = FALSE, sep = "", nrows=MAX_ROWS)
test_activity <- read.table(filename_test_activity, header = FALSE, sep = "", nrows=MAX_ROWS)
activities <- read.table(filename_labels_activity, header = FALSE, sep = "")

# combine train/test activity columns and replace with long names
activity_combined <- rbind(train_activity, test_activity)
activity_combined <- merge(activity_combined, activities, by = "V1")
activity_combined_desc <- data.frame(activity_combined$V2)
names(activity_combined_desc) <- "Activity"

## combine train/test subject column and add column name
train_subject <- read.table(filename_train_subject, header = FALSE, sep = "", nrows=MAX_ROWS)
test_subject <- read.table(filename_test_subject, header = FALSE, sep = "", nrows=MAX_ROWS)
subject_combined <- rbind(train_subject, test_subject)
names(subject_combined) <- "SubjectID"

## combine train and test measurements and assign column names using features file

# load feature names and sort according to index column
features_df <- read.table(filename_labels_features, header = FALSE, sep = "")
features <- features_df[order(features_df$V1),]$V2

# load measurements
train_measurement <- read.table(filename_train_measurement, header = FALSE, sep = "", nrows=MAX_ROWS)
test_measurement <- read.table(filename_test_measurement, header = FALSE, sep = "", nrows=MAX_ROWS)

# combine training and testing measurements together, and assign column names
measurement_combined <- rbind(train_measurement, test_measurement)
names(measurement_combined) <- features

## product tidy data according to assignment rules

# grab only subset of measurements that has to do with mean and standard deviation
measurement_subset <- subset(measurement_combined, select = grep("mean|std", features, value = TRUE))

# combine everything together
tidy_data <- cbind(measurement_subset, activity_combined_desc, subject_combined)

# create new key for activity_subject
activity_subject <- paste(tidy_data$Activity, tidy_data$SubjectID, sep="_")

# take the average of measurement, but grouped by Activity_SubjectID
tidy_data_grouped <- apply(measurement_subset, 2, function(x) tapply(x, activity_subject, mean, na.rm=TRUE))

# converting to data frame here converts to 3-column long-form.
tidy_data_grouped_df <- as.data.frame(as.table(tidy_data_grouped))
names(tidy_data_grouped_df) <- c("Activity_SubjectID", "Measurement", "AverageValue")

## write output file

write.table(tidy_data_grouped_df, file = "tidy_data.txt")
