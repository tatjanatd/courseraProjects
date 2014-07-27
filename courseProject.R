### The purpose of this project is to demonstrate your ability to collect, 
## work with, and clean a data set. The goal is to prepare tidy data that can be used for 
## later analysis. You will be graded by your peers on a series of yes/no questions related 
## to the project. You will be required to submit: 1) a tidy data set as described below, 2) 
## a link to a Github repository with your script for performing the analysis, and 3) 
## a code book that describes the variables, the data, and any transformations or work that 
## you performed to clean up the data called CodeBook.md. You should also include a README.md 
## in the repo with your scripts. This repo explains how all of the scripts work and 
## how they are connected. 

## One of the most exciting areas in all of data science right now is wearable computing - 
## see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to 
## develop the most advanced algorithms to attract new users. 
## The data linked to from the course website represent data collected from the accelerometers 
## from the Samsung Galaxy S smartphone. A full description is available at the site where the 
## data was obtained: 
        
        
## You should create one R script called run_analysis.R that does the following. 

## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## variable names
activity <- read.table(paste(getwd(), "/UCIHARDataset/activity_labels.txt", sep=""))

tnames <- read.table(paste(getwd(), "/UCIHARDataset/features.txt", sep=""))
dim(tnames)
head(tnames, 9)

getwd()
pathdata <- "UCI HAR Dataset"
d1 <- read.table(paste(getwd(),"/UCIHARDataset/train/X_train.txt", sep=""))
dim(d1)
names(d1)
d1a <- read.table(paste(getwd(),"/UCIHARDataset/train/y_train.txt", sep=""))
dim(d1a)
head(d1a)
tail(d1a)
table(d1a)
d1b <- read.table(paste(getwd(),"/UCIHARDataset/train/subject_train.txt", sep=""))
table(d1b)

d2 <- read.table(paste(getwd(),"/UCIHARDataset/test/X_test.txt", sep=""))
dim(d2)
names(d2)
d2a <- read.table(paste(getwd(),"/UCIHARDataset/test/y_test.txt", sep=""))
dim(d2a)
head(d2a)
tail(d2a)
table(d2a)
d2b <- read.table(paste(getwd(),"/UCIHARDataset/test/subject_test.txt", sep=""))
table(d2b)

dim(d1)[1]+dim(d2)[1]

d1$activity <- d1a$V1
d1$subject <- d1b$V1
d2$activity <- d2a$V1
d2$subject <- d2b$V1
####

d <- rbind(d1, d2)
dim(d) # 10299
names(d)[1:561] <- as.character(tnames$V2)
indices <- sort(c(grep("mean",names(d)), grep("std",names(d)), which(names(d) %in% c("activity", "subject")) ))
names(d)[grep("meanFreq",names(d))]
dnew <- d[, indices]
names(dnew)
# names(d)[grep("std",names(d))]
# names(d)[grep("mean",names(d))]
# names(d)[grep("Mean",names(d))]
table(dnew$activity)
dnew$activity <- factor(dnew$activity, levels=1:6, labels=activity$V2)

table(dnew$subject, dnew$activity)


# tidy data set: pro person 6 zeilen (6 activities)
## von 10299 reduzieren auf 6*30=180
## dcast???
dagg <- aggregate(dnew[, -(80:81)], by=list(Activity=dnew$activity, Subject=dnew$subject), mean)
str(dagg)
dsplit <- split(dnew, dnew$)