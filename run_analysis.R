# Process the "Human Activity Recognition Using Smartphones" dataset
#
# Did as part of corsera project work
# Required packages are "dplyr" and "tidyr"
#
# If the dataset is not present in the current working directory then download it
if (!file.exists("UCI HAR Dataset")) {
        if (!file.exists("SamsungData")) {
                dir.create("SamsungData")
        }
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, "./SamsungData/UCI HAR Dataset.zip", mode = "wb")
        unzip("./SamsungData/UCI HAR Dataset.zip", exdir = "./SamsungData")
        setwd("./SamsungData/UCI HAR Dataset")
}

# ------------------------------------------------------------------------------
# Step 1 - Merges the training and the test sets to create one data set.
# ------------------------------------------------------------------------------
x.train <- read.table("./train/X_train.txt", header = F, stringsAsFactors = F)
y.train <- read.table("./train/y_train.txt", header = F, stringsAsFactors = F)
x.test <- read.table("./test/X_test.txt", header = F, stringsAsFactors = F)
y.test <- read.table("./test/y_test.txt", header = F, stringsAsFactors = F)
subject.test <- read.table("./test/subject_test.txt", header = F, stringsAsFactors = F)
subject.train <- read.table("./train/subject_train.txt", header = F, stringsAsFactors = F)
test.data <- cbind(subject.test, y.test, x.test)
train.data <- cbind(subject.train, y.train, x.train)
data <- rbind(train.data, test.data)
data <- tbl_df(data)
names(data)[1:2] <- c("subject", "activity")

# ------------------------------------------------------------------------------
# Step 2 - Extracts only the measurements on the mean and standard deviation for 
# each measurement.
# ------------------------------------------------------------------------------
# read features
features <- read.table("features.txt", header = F, stringsAsFactors = F)

# filter only features that has mean or std in the name
feat.ind <- setdiff(grep("mean|std", features$V2), grep("meanFreq", features$V2))
data <- data %>% select(c(1,2,feat.ind + 2))

# ------------------------------------------------------------------------------
# Step 3 - Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------
act.label <- read.table("activity_labels.txt", header = F, stringsAsFactors = F)
data$activity <- factor(as.numeric(data$activity), labels = act.label$V2)

# ------------------------------------------------------------------------------
# step 4 - Appropriately labels the data set with descriptive variable names.
# ------------------------------------------------------------------------------
filt.feat <- features$V2[feat.ind] %>% gsub("\\(\\)", "", .) %>% 
        gsub("Acc", "-acceleration", .) %>% gsub("Mag", "-magnitude", .) %>%
        gsub("(Jerk|Gyro)", "-\\1", .) %>% gsub("^t(.*)$", "Time-\\1", .) %>%
        gsub("^f(.*)$", "Frequency-\\1", .) %>% gsub("BodyBody", "Body", .) %>%
        tolower
names(data) <- c("subject", "activity", filt.feat)

# ------------------------------------------------------------------------------
# step 5 - From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
# ------------------------------------------------------------------------------
tidy.data <- data %>% group_by(subject, activity ) %>% summarise_each(funs(mean)) %>%
        gather("measurement", "mean", -activity, -subject)

# Save the data into the file
write.table(tidy.data, file="tidy_data.txt", row.name=FALSE)