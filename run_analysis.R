#G&C project
library(plyr)

#load/merge test + train subjectID data containing geach data points Subject ID
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
subjectAll <- rbind(subject_test, subject_train)
names(subjectAll) <- "subjectId" ##name single column

#merge xtest and xtrain data into one
xTest = read.table("UCI HAR Dataset/test/X_test.txt")
xTrain = read.table("UCI HAR Dataset/train/X_train.txt")
xAll <- rbind(xTest, xTrain)

#subset xAll into just specified features (mean and std)
featuresAll <- read.table("UCI HAR Dataset/features.txt", col.names = c("featureId", "featureLabel"))
featuresOnly <- grep("-mean\\(\\)|-std\\(\\)", featuresAll$featureLabel)
#subset xAll (561) by just featuresOnly (66)
xAll <- xAll[, featuresOnly]
##replace featureID column names in xAll with feature Label
names(xAll)<-featuresAll[featuresOnly,2]

##xAll now containes every subjects x/y/x info fall for the 66 specified mean/std features

#merge ytest and ytrain into yfull with each observations activity ID
yTest = read.table("UCI HAR Dataset/test/Y_test.txt")
yTrain = read.table("UCI HAR Dataset/train/Y_train.txt")
yAll <- rbind(yTest, yTrain)

#load activities (walk sit...) name columns and get rid of underscores
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"))
activities$activityLabel <- gsub("_", "", as.character(activities$activityLabel)) 

#replace activityID in yAll with corresponding descriptive activity name and rename column
yAll[,1] <- activities[yAll[,1],2]
names(yAll) = "activity"

#merge feature data in xAll with activity data in yAll with subject data in subjectAll
##subjectAll containes subjectID of all 10299 data points
##xAll contains feature value for all 10299 values
##yAll contains activity value for all 10299 values
final <- cbind(subjectAll, yAll, xAll)

##get rid of confusing abbreviations in column names with gsub()
names(final) = gsub('Freq$', 'frequency', names(final))
names(final) = gsub('Freq\\.', 'frequency', names(final))
names(final) = gsub('Acc', 'acceleration', names(final))
names(final) = gsub('Mag', 'magnitude', names(final))

##create tidy data set with the average of each feature for each subject and activity.
finalTidy <- ddply(final, c("subjectId", "activity"), numcolwise(mean))
write.table(finalTidy, file = "final_tidy_data", row.name = FALSE)
