#-----------------------------------------------------------------------------------------------------#
# 							GENERAL INFORMATION
#-----------------------------------------------------------------------------------------------------#
# File description:
#	Name
#		IntroR_solution_exercise_1.R
#
#	Purpose 
#		This code was made as a solution of "Exercise 1" in the 'Introduction to R' course (PSY4373). 
#		Additional questions or comments can be directed to the course coordinator, Ehsan Pishva (e.pishva@maastrichtuniversity.nl).
#		Exercise 1 can be found on https://ehsanpishva.github.io/IntroR-PSY4373/w1e.html
#
# Author comment:
#	Rick Reijnders
#	ra.reijnders@maastrichtuniversity.nl
#


#-----------------------------------------------------------------------------------------------------#
#							Exercise description
#-----------------------------------------------------------------------------------------------------#
#These exercises all use the data frame you can dowload from the link provided above (“inflammation-01.csv”). First we need to import it as a variable dat. The dataset contain a cytokine measurement for 40 consecutive days of in 60 individuals.

#1) Select from the data frame ‘dat’:
#- The element on the 4th row and 2nd column.
#- The element on the 7th row and 5th column.
#- The 10th row.
#- The 3rd column.

#2) Let’s calculate some summary statistics for specific individuals #(rows) and days (columns).
#- Calculate the mean inflammation score for the first individual.
#- Calculate the median inflammataion score for the 5th day.
#- Use min() and max() to calculate the range of values for the 10th individual.
#- Check you answer with the range() function.
#- Use quantile() to calculate the [interquartile range] (https://en.wikipedia.org/wiki/Interquartile_range) of the 6th indiviudal.


#3) Using the inflammation data frame inflammation-01.csv: Let’s pretend there was something wrong with the instrument on the first five days for every second patient (#2, 4, 6, etc.), which resulted in the measurements being twice as large as they should be.
#- Write a vector containing each affected patient (hint: ? seq)
#- Create a new data frame with in which you halve the first five days’ values in only those patients
#- Print out the corrected data frame to check that your code has fixed the problem

#-----------------------------------------------------------------------------------------------------#
#							Loading data
#-----------------------------------------------------------------------------------------------------#

# First set the directory to where the downloaded files are located
setwd("C:/Users/p70072451/Downloads")

# This is also correct:
# setwd("C:\\Users\\p70072451\\Downloads") # this is due to the direction of the slash ( / or \ ). 
# \ is often used as an escape character, indicating a special use for the upcoming character. E.g. \t means tab

# As the file is a csv file, use read.csv to load this file
# Header is set to TRUE as the first row of the data are headers (and not values)
# row.names is set to 1 as the first column contain the rownames (and not values)
dat <- read.csv(file = "inflammation-01.csv", header = TRUE, row.names = 1)


#-----------------------------------------------------------------------------------------------------#
#							1) Indexing
#-----------------------------------------------------------------------------------------------------#
# The element on the 4th row and 2nd column
# As the indexing of objects is done by using "[row,colum]" this translates to dat[4,2]
dat[4,2]

# The element on the 7th row and 5nd column
dat[7,5]

# The 10th row
# By specifying only the row or column, a vector is created contining all specified values. This translates to dat[10,]
dat[10,]

# The 3rd column.
dat[,3]


#-----------------------------------------------------------------------------------------------------#
#							2) summary statistics
#-----------------------------------------------------------------------------------------------------#
# Calculate the mean inflammation score for the first individual
# The first individual can be found on dat[1,]. By applying the mean on the vector dat[1,], the mean of subject 1 is extracted
mean(dat[1,])

# This results in an error, "argument is not numeric or logical". This means the inserted data is not a number, but something else. By using str(dat[1,]) it can be observed all numbers are of class "int", interger. To change this from interger to numeric, as.numeric() can be used
mean(as.numeric(dat[1,]))

# Calculate the median inflammataion score for the 5th day
# The fifth day can be found on dat[,5]. By applying the median on the vector dat[,5], the median of day 5 is extracted
median(dat[,5])

# Use min() and max() to calculate the range of values for the 10th individual
# The 10th individual can be found on dat[10,]. By applying min() and max() we get the range of values in the 10th individual. 
min(dat[10,])
max(dat[10,])

# Check you answer with the range() function.
# The range function results the min and max as a vector.  
range(dat[10,])
range(dat[10,])[1] # min
range(dat[10,])[2] # max

# Use quantile() to calculate the interquartile range of the 6th indiviudal.
# he 6th individual can be found on dat[6,]. By applying quantile(), the range of quantiles is given for indiviual 6. It can be specified which quantile is required, e.g. quantile(dat[6,],probs=0.98) refers to the 98th quantile.
quantile(dat[6,])


#-----------------------------------------------------------------------------------------------------#
#							3) error instrument
#-----------------------------------------------------------------------------------------------------#
# Write a vector containing each affected patient (hint: ? seq)
# In the text it is stated for first 5 days every second patient has twice as large measurements.
# Lets think about this step for step
# For the first 5 days, so only dat[,1:5] is needed
# Every second patient, then we need the the amount of patients in total to start with. By using dim(dat) the amount of rows and columns is resulted. Patients are rows, so dim(dat)[1] results the amount of patients, which is 60. 
# Then every second patient, a pattern of 2,4,6...58,60. This can be done by the function seq(). This function takes arguments from, to and by. Stating make a sequence starting 'from' 2 'to' 60 'by' 2 steps at a time
# The first question is the vector containing each affected patient
Affected_patients_index <- seq(from=2,to=dim(dat)[1],by=2)

# Create a new data frame with in which you halve the first five days’ values in only those patient svector containing each affected patient
# Using the vector from above the correct samples (rows) can be selected, now the days (columns) need to be correctly selected. This can be achieved by dat[Affected_patients_index,1:5], it extracts the values. The only thing to be done now is to halve those values and store it into a new object.

Affected_data = dat[Affected_patients_index,1:5] / 2

# Print out the corrected data frame to check that your code has fixed the problem.
# If the original data needed to be replaced, it would be achieved like below.
print(Affected_data)
dat[Affected_patients_index,1:5] = Affected_data

