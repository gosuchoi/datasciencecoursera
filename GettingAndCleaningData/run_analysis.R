#  function : run_analysis
#  Author : Wooseog Choi
#  Date : 2015. 4. 24
#
# This program is to generate tidy dataset from raw data given by
# the Getting and Cleaning Data class in Coursera.
#

run_analysis<-function()
{
        library(dplyr)

        feature<-read.table("features.txt")
        # Get only mean and standard deviation
        featureflag<-lapply(data.frame(t(feature)), function(elt) grep("*mean\\(\\)*|*std\\(\\)*", elt[2]))
        selfeature<-subset(feature, featureflag == 1)
        cvector<-as.vector(selfeature[,1])     # column indices
        cnamevector<-as.vector(selfeature[,2])   #  column names
        # Read test data
        testdata<-read.table("test/X_test.txt")
        # Select only mean and standard deviation
        testmeanstd<-select(testdata, cvector)
        # Add column names
        colnames(testmeanstd)<-cnamevector
        testmeanstd<-mutate(testmeanstd, DataType="test")
        testmeanstd<-select(testmeanstd,c(ncol(testmeanstd), 1:(ncol(testmeanstd) -1)))
        # Read activity file
        testact<-read.table("test/y_test.txt")
        # Assign column name
        colnames(testact)<-c("Activity")
        # merge the activity table to data table
        testmeanstd<-cbind(testact, testmeanstd)
        # Read volunteers file
        testsub<-read.table("test/subject_test.txt")
        # Assign column name
        colnames(testsub)<-c("Subject")
        # merge the subject table to data table
        testmeanstd<-cbind(testsub, testmeanstd)
       
        
        #read training data
        traindata<-read.table("train/X_train.txt")
        trainmeanstd<-select(traindata, cvector)
        colnames(trainmeanstd)<-cnamevector
        trainmeanstd<-mutate(trainmeanstd, DataType="train")
        trainmeanstd<-select(trainmeanstd,c(ncol(trainmeanstd), 1:(ncol(trainmeanstd) -1)))
        # Read activity file
        trainact<-read.table("train/y_train.txt")
        # Assign column name
        colnames(trainact)<-c("Activity")
        # merge the activity table to data table
        trainmeanstd<-cbind(trainact, trainmeanstd)
        # Read volunteers file
        trainsub<-read.table("train/subject_train.txt")
        # Assign column name
        colnames(trainsub)<-c("Subject")
        # merge the subject table to data table
        trainmeanstd<-cbind(trainsub, trainmeanstd)
        
        # Finally merge two data sets
        onedata<-merge(trainmeanstd, testmeanstd, all=TRUE)
        
        # replace the activity code with more descriptive words
        actlabels<-read.table("activity_labels.txt")
        onedata[,2]<-sapply(onedata[,2], function(etl) as.character(actlabels[etl, 2]))
        # sort the tabed by subject and activity
        arrange(onedata, Subject, Activity) %>%
                write.table(file="merged_data.txt", row.names=FALSE)
        # generate new table with mean of all columns
        aggregate(onedata[, 4:69], by=list(Subject=onedata$Subject, Activity=onedata$Activity, DataType=onedata$DataType), mean) %>%
                arrange( Subject, Activity) %>% 
                        write.table(file="result_mean.txt", row.names=FALSE)


}