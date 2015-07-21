#Coursera Getting and Cleaning Data Project

##How the script works
1. downloads and unzips datasets
2. loads subject train and test data and combine into subjectAll
3. loads x train and x test data and combine into xAll
4. pairs down and subsets xAll into just mean and std variables using features dataset
5. loads y test and y train and merge into yAll and label/name using activities dataset
6. joins subjectAll, xAll and yAll data frames into final
8. names data set with descriptive namesa and replaces abbreviations.
9. creates independant finalTidy dataset with the average of each variable for each activity and each subject
10. writes finalTidy to txt file


