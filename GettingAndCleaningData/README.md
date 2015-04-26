File Name : run_analysis.R
What is required before running this program?
This program is to generate mean values for mean and standard daviation variables in the test and train data getting from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
This file MUST be in the "UCI HAR Dataset" directory after unzipping the file downloaded.
How to run it?
Steps to run the program is:
1) Open R.
2) Change the working directory to "UCI HAR Dataset" directory using setwd() command.
3) Load the source file using source("run_analysis.R").
4) Run the program withe the command, run_analysis().
What will be generated?
The result_mean.txt file will be made in the "UCI HAR Dataset" directory as results.
How the program works?
The program is doing the following steps to generate the result file.
Step 1) It will read test/X_test.txt file, which has the data for test experiements, and then read the features.txt files which has all the features of the data, variables in the data table.
Step 2) It will get only mean() and std() variables from the feature table along with the column indices of the variables in the data table.
Step 3) As next step, using the indices of the step2 it will select  only the columns indicated by the indices from the data table. 
Step 4) It addes variable names from feature table and adds one more column with variable name DataType and value "test" indicating data from test experiments. And it will move the DataType column to the first column.
Step 5) As final stage with test data, it will add two more column for indicating the feature of each row and indicating subject, volunteer of the experiments, of each row.
Step 6) It does the step1) to step5) for train data as well.
Step 7) It will merge the two tables, one from test data and one from train data and repalce the activity codes with names of activity in order to make them more descriptive.
Step 8) After sorting the merged table, it will write it into disk as interim table.
Step 9) As final stage, it will calculate mean vaules per Subjects and Activities for all variables and write the table into the disk after sorting it by Subjects and Activities.
What is made by running this program?
It will generate a file named result_mean.txt in the current working directory which is under "UCI HAR Dataset". 
