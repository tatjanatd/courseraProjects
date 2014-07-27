## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## variable names
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

tnames <- read.table("UCI HAR Dataset/features.txt") # 561 x 2, V2 contains variable-names
dim(tnames)

## load training data set
d1 <- read.table(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt", sep=""))
dim(d1)
names(d1)
## Activity IDs, training dataset
d1a <- read.table(paste(getwd(),"/UCI HAR Dataset/train/y_train.txt", sep=""))
dim(d1a)
table(d1a)
## subject IDs, training dataset
d1b <- read.table(paste(getwd(),"/UCI HAR Dataset/train/subject_train.txt", sep=""))
table(d1b)
d1$activity <- d1a$V1
d1$subject <- d1b$V1

##### TEST DATA
d2 <- read.table(paste(getwd(),"/UCI HAR Dataset/test/X_test.txt", sep=""))
dim(d2)

## Activity IDs, test dataset
d2a <- read.table(paste(getwd(),"/UCI HAR Dataset/test/y_test.txt", sep=""))
dim(d2a)
table(d2a)
## Subject IDs, test dataset
d2b <- read.table(paste(getwd(),"/UCI HAR Dataset/test/subject_test.txt", sep=""))
table(d2b)

d2$activity <- d2a$V1
d2$subject <- d2b$V1
d1$datasettype <- rep("training", nrow(d1))
#d2$activity <- factor(d2a$V1, levels=1:6, labels=as.character(activity$V2))
d2$datasettype <- rep("test", nrow(d2))
####
## (1)
d <- rbind(d1, d2)
dim(d) # 10299

## (2)
## choose only important columns: activity, subject, all columns about mean & std
names(d)[1:561] <- as.character(tnames$V2)
indices <- sort(c(grep("mean",names(d)), grep("std",names(d)), which(names(d) %in% c("activity", "subject", "datasettype")) ))
names(d)[grep("meanFreq",names(d))]
indices2 <- indices[!(indices%in% grep("meanFreq",names(d)) )]
dnew <- d[, indices]  # which is right: 82 or 69 columns??
names(dnew)
## (3)
dnew$activity <- factor(dnew$activity, levels=1:6, labels=activity$V2)
table(dnew$activity)
## (4) descriptive variable names were made in step 2 in order to find mean, std columns
#names(dnew)[1:561] <- as.character(tnames$V2)

table(dnew$subject, dnew$activity)

write.table(dnew, file="tidydata.txt", row.names=FALSE)

# tidy data set: per person 6 rows (=6 activities)
## (5)
dagg <- aggregate(dnew[, -(80:82)], by=list(Activity=dnew$activity, Subject=dnew$subject), mean)
str(dagg)  # data frame 180 obs. of 81 variables
head(dagg)
write.table(dagg, file="tidydata_aggregated.txt", row.names=FALSE)
