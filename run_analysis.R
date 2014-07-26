## Getting and Cleaning Data Project

## read in only the mean() and std() features from the original data set
value1 <- "mean()"
value2 <- "std()"
features <- read.table("~/R/GCDproject/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
char <- features[,2]
logical1 <- grepl(value1, char)
logical2 <- grepl(value2, char)
logical <- logical1 | logical2
vector <- which(logical)
select <- rep("NULL", 561)
for(i in 1:561){
        if(i %in% vector){
                select[i] <- "numeric"
        }
}
cnames <- char[vector]

X_test <- read.table("~/R/GCDproject/UCI HAR Dataset/test/X_test.txt", colClasses=select)
X_train <- read.table("~/R/GCDproject/UCI HAR Dataset/train/X_train.txt", colClasses=select)

Y_test <- read.table("~/R/GCDproject/UCI HAR Dataset/test/Y_test.txt")
Y_train <- read.table("~/R/GCDproject/UCI HAR Dataset/train/Y_train.txt")

sub_test <- read.table("~/R/GCDproject/UCI HAR Dataset/test/subject_test.txt")
sub_train <- read.table("~/R/GCDproject/UCI HAR Dataset/train/subject_train.txt")

train <- cbind(X_train, Y_train)
test <- cbind(X_test, Y_test)

train <- cbind(sub_train, train)
test <- cbind(sub_test, test)

colnames(train) <- c("subject", cnames, "act_number")
colnames(test) <- c("subject", cnames, "act_number")

new_data <- rbind(train, test)

activity = c("WALKING",
             "WALKING_UPSTAIRS",
             "WALKING_DOWNSTAIRS",
             "SITTING",
             "STANDING",
             "LAYING")

act_list <- character()
for(i in 1:nrow(new_data)){
        new_data[i,81] <- as.numeric(new_data[i,81])
        act_num <- new_data[i,81]
        act_list <- c(act_list, activity[act_num])
}
new_data$activity <- act_list

## average of each variable for each activity and each subject
s <- split(new_data, list(new_data$subject, new_data$activity))
result <- sapply(s, function(x) colMeans(x[, 2:80]))

write.table(result, "./dataset_byLogan.txt", sep = " ")