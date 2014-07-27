courseraProjects
================

project assignments

Please go to the Branch: mynewbranch! there is the run_analysis and the readme.md


ourse project 
================

In the following it is explained what is done in the file **run_analysis.R**.

It is assumed, that the Samsung data was unpacked and the resulting folder 'USI HAR Dataset' lies in the working directory.

1. From the Samsung data files, activity_labels.txt and features.txt, are loaded. 
* The former contains the labels for each of the six activities. 
They are needed since the activities given for each row in the data set are coded numerically. 
* The file features.txt contains all the 561 variable names that correspond to the 561 columns 
     in the training and in the test data set.

2. The training data set, X_train.txt, is loaded in the data frame with the name d1. The test data set, X_test.txt is saved in the data frame d2.

3. For the training data set, the activity vector, y_train.txt, is loaded. The same is done for the test data with y_test.txt.

4. There are 30 subjects numbered 1 to 30. Since both data sets contain several rows for each subject, the files subject_train.txt and subject_test.txt are loaded to identify the subjects in the data sets. It is assumed that the rows in subject text file correspond to the rows in the respective data set. 
* The training data set gets two new columns subject and activity with the subject IDs and the activity vector. Also, a new column datasettype full with the character "training" is added.
* The test data set gets two new columns with the corresponding subject IDs and the activity vector. The column datasettype containing the word "test" is added.

5. The test and the training data sets are merged by the command "rbind".

6. The Labels from step (1) are applied to the merged data set. That means, the columns get the names from features.txt and the activity columns becomes a factor variable with the activity labels from activity_labels.txt.

7. Using the function grep, the important columns, that contain the character "mean" or "std", are selected. This tidy data set is exported in a text file.

8. Using the function aggregate, mean values of the remaining 79 (Samsung-)variables, are calculated for each person and each activity. This tidy data set is also exported into a text file.
