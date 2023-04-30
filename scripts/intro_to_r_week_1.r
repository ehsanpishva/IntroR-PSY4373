############################################################################

# What is R?

# - R is a system for the manipulation, statistical and numerical analysis,
#   and graphical display of data
# - freely available under the GNU General Public License (GPL)
# - open-source and free/libre
# - runs under Windows, macOS, Unix/Linux, ...

# Why is it Called R?

# - in 1992, *R*obert Gentleman and *R*oss Ihaka started developing this
#   programming language: https://en.wikipedia.org/wiki/R_(programming_language)

# Why R?

# - R code is great for reproducibility
# - R is interdisciplinary and extensible
# - R works on data of all shapes and sizes
# - R produces high-quality graphics
# - R has a large user community
# - R is free and also open-source and cross-platform

# Working with R

# - R is command-driven (no point-and-click interface)
# - an 'object-oriented' and 'functional' language
# - R console: where you enter the commands
# - symbol at beginning of line (>): the 'prompt'

# RStudio

# - an 'integrated development environment' (IDE) for R
# - freely available, open-source, and cross-platform
# - makes working wit R a lot more pleasant

# Always Use Script Files

# - promotes organized programming/analyses and code reuse
# - increases replicability
# - easier to fix errors/mistakes
# - RStudio has a nice built-in script editor

############################################################################

# start RStudio

# open this script: Menu 'File' - Open File (or Ctrl+o / Command+o)

# elements ('panes') of RStudio:
# - top left:     Script Editor
# - bottom left:  Console
# - top right:    Environment, Command History, Connections
# - bottom right: File Browser, Plots, Packages, Help, Viewer

# first check that it says "R version 4.3.0" in the Console; if not, you do
# not have the current version of R installed (maybe you should update,
# especially if the version you have installed is quite old ...)

############################################################################

# running commands from a script file

# you can run a command from the script by putting the cursor in the same line
# as the command and then using the keyboard shortcut:
# - Windows: Ctrl+Enter
# - macOS:   Command+Enter

x <- c(4,2,3,6)
mean(x)

# note that the cursor automatically moves to the next line each time you use
# the shortcut, so this way you can quickly run through a bunch of commands
#
# you can also select/highlight multiple lines and run them all at once

# to see the contents of an object, just type its name

x

# that is in fact just a shortcut for using the print() function

print(x)

# note: object 'x' is listed under 'Environment' in RStudio (top right pane)

# the 'Environment' lists all objects in your 'workspace'; these can be simple
# things like 'x', datasets, the results from some statistical analysis, etc.

############################################################################

# check what objects are in the workspace

x <- 1
y <- 2
z <- 55

# list objects in the environment (see also 'Environment' in RStudio)

ls()

# remove an object from the workspace

rm(x)
ls()

# clear the entire workspace

rm(list=ls())
ls()

# character(0) stands for an empty 'character vector' (more on this later)

############################################################################

# working directory

# the 'working directory' is the directory (i.e., folder) where R will look
# for files (e.g., datasets you want to load) or where it will save files to
# (e.g., graphs you want to save so that they can be imported into a paper or
# presentation; we will learn how to do this later on)

# check your working directory

getwd()

# if this is *not* the directory/folder where you put the course materials:
#
# Menu 'Session' - 'Set Working Directory' - 'To Source File Location'
#
# this sets the working directory to the location of the script (note that
# this actually runs the setwd() command with the correct location)

# check your working directory again

getwd()

# another approach: in the 'Files' tab in the bottom right pane, click your
# way to the directory/folder with the materials, then click 'More' (or the gear
# looking symbol), and select 'Set As Working Directory'

# don't forget to save the script once in a while (Ctrl+s / Command+s) and add
# comments to the script as needed

############################################################################

# we start with some basic data structures

# scalars

x <- 2.5

# you can read this as: 'assign the value 2.5 to an object called x'

x

# can also use =

x = 5
x

# note: 'x' is overwritten (when 'x' is an existing object name)

# character strings need to be in quotes and can have spaces

x <- "Hello World!"
x

# numeric vectors

x <- c(2,5,4)
x

# note: c() is the 'combine' function

# can add spaces

x <- c(2, 5, 4)
x

# character/string vectors

x <- c("Male", "Male", "Female", "Female")
x

# quickly create a vector of consecutive numbers

x <- c(1:100)
x

# actually don't even need c() here

x <- 1:100
x

# note: if the vector is too long to fit into a single line, the output is
# wrapped and the numbers in brackets (e.g., [1]) indicate the position of
# the value that comes next

# if you mix numbers and strings, you get a character vector

x <- c("Bob", "Sue", "John", 2, 5)
x

# sidenote: this is called 'type coercion' and R uses a set of rules to do so
# (for better or for worse ...)

# logicals (TRUE/FALSE are special keywords)

x <- c(TRUE, FALSE, FALSE)
x

# can be abbreviated to T/F, but better avoid this

x <- c(F, F, T)
x

# comparisons (note that they lead to logicals)

x <- c(2, 4, 6, 3, 5)
x

x > 3
x >= 3
x < 3
x <= 3
x == 3
x != 3

# note the == for comparing each element in x with the number 3; if you would
# use x = 3, then you would assign 3 to x, which is not what we want

# != means 'not equal to'

# and/or (the parentheses are not necessary here, but make the code clearer)

(x > 3) & (x < 6)
(x < 3) | (x > 5)

# find the position of TRUE values

x > 3
which(x > 3)

# missing values

# say x is equal to 2 and 4 for the first and third person, but unknown for
# the second person; how can we specify this?

x <- c(2,,4)

# nope!

x <- c(2, ,4)

# nope!

# but this works

x <- c(2, NA, 4)
x

# note: NA = not available (another special keyword)

# object/variable names:
# - must begin with a letter
# - contain alphanumeric symbols (A-Z, a-z, 0-9)
# - can also use . and _
# - are case-sensitive

# sometimes we may come across 'named' vectors

age <- c(25, 21, 30)
age

age <- c("Bob"=25, "Sue"=21, "John"=30)
age

# can also simplify this

age <- c(Bob=25, Sue=21, John=30)
age

############################################################################

# basic arithmetic with + - * / ^ log() exp() and so on
# be careful with order of operations (use parentheses as needed)

2 * 5 - 4 / 2 + 4
2 * ((5 - 4) / 2) + 4

4^2

log(2)   # natural log
log10(2) # log to base 10

exp(1)

# a few special cases

2/0
(-2)/0
0/0

# Note: NaN = not a number (https://en.wikipedia.org/wiki/NaN)

# scientific notation

100000000
10^8
0.00000001
10^-8

# if you find scientific notation confusing

options(scipen=100)

100000000
0.00000001

# if you want to, you can set 'scipen' back to the default (0)

options(scipen=0)

# note: changes to the options are not permanent (if you restart R/RStudio,
# the default settings are in effect)

############################################################################

# vectorized operations

# this means that a command does something to every element of an object

x <- c(2,4,3,5,7)
x

x * 2
x^2
log(x)

# an example of a non-vectorized operation

mean(x)

############################################################################

# clear the entire workspace

rm(list=ls())

# or just restart the R session (Menu 'Session' - 'Restart R')

# most datasets are just a bunch of vectors (of the same length) combined into
# what is called a 'data frame'; let's create such an object manually

id  <- c("Bob", "Sue", "John")
age <- c(25, 21, 30)
sex <- c("Male", "Female", "Male")
grp <- c("Trt", "Trt", "Ctrl")

dat <- data.frame(id, age, sex, grp)
dat

# notes:
# - on the very left, we have the row names (not a variable!); by default,
#   they are just consecutive numbers, but don't have to be
# - character variables are not shown with quotes

# note: in the Environment pane, we now have a 'Data' object called 'dat'
#
# can click on 'dat' to view the contents (more useful for larger datasets)
#
# this is not for editing; we do not make any manual changes to our data!
# this is the same as using the View() command

View(dat)

# note: R is case-sensitive

view(dat)

# clean up the workspace a bit (keep things tidy!)

ls()

rm(id, age, grp, sex)

ls()

# accessing individual variables within a data frame

dat$id
dat$age
dat$sex
dat$grp

# subsetting (value before the comma is the row, value after is the column)

dat
dat[1,2]

# subsetting (columns)

dat[,2]
dat[,c(1,4)]

# note: if you take a single column, you get a vector

# for data frames, we can also use a special notation to select columns

dat[2]
dat[c(1,4)]

# careful: with this notation, taking a single column returns a data frame
# with that column (and not a vector with the values of that column)

# can also refer to columns by their variable names

dat[,"age"]
dat[,c("id","grp")]

dat["age"]
dat[c("id","grp")]

# subsetting (rows)

dat[1,]
dat[c(1,2),]

# combine selection of rows and columns

dat[1:2, c("id","grp")]

# subsetting with logicals

dat$sex
dat$sex == "Male"
dat[dat$sex == "Male",]

# you can read this as: from 'dat', give me all rows where variable 'sex' from
# 'dat' is equal to 'Male'

# hence the following does not work

dat[sex == "Male",]

# have to be explicit where the variable for the comparison can be found

dat[dat$sex == "Male",]

# note: such subsetting will just return the dataset for the males, but this
# is not a permanent selection; examine object 'dat' again

dat

# if you want to make a permanent selection, you have to assign this output to
# an object (either overwrite the original object or make a new one)

dat.m <- dat[dat$sex == "Male",]
dat.f <- dat[dat$sex == "Female",]
dat.m
dat.f

# note: in R, we can have an unlimited number of objects (including data
# frames) available at the same time (see the Environment pane); this can get
# confusing quickly, so try to keep your workspace tidy (i.e., remove objects
# you no longer need)

rm(dat.m, dat.f)

# using the subset() command

subset(dat, sex == "Male")
subset(dat, age >= 25)
subset(dat, grp == "Trt")

# note: the subset() command is clever enough to look for the variables used
# for the subsetting inside of the dataset itself!

# subset() can also be used to select one or multiple columns

subset(dat, select = c(age, sex))

# can also use this to subset rows and select columns at the same time

subset(dat, sex == "Male", select = c(age, sex))
subset(dat, sex == "Male", select = age)
subset(dat, sex == "Male", select = age, drop = TRUE)

# drop = TRUE to turn the one column data frame into a vector

# add a new variable to a data frame

dat
dat$y <- c(5, 7, 999)
dat

# how to sort a data frame

dat
order(dat$age)

# this means: the 2nd person has the lowest age, the 1st person has the next
# higher age, and the 3rd person has the highest age

# so we can use this order using the 'subsetting' notation introduced earlier

dat[order(dat$age),]

# now the entire dataset has been sorted correctly by age

# but again, this is not permanent

dat

# to make this permanent, back-assign it

dat <- dat[order(dat$age),]
dat

# value replacement (suppose 999 actually stands for missing data)

dat$y
dat$y==999
dat$y[dat$y==999] <- NA
dat

# note: the variable that is being changed does not have to be the same
# variable that is used to select cases

dat$y[dat$id == "John"] <- 8
dat

# this way you can make corrections to a dataset

# rename a variable

dat
names(dat)
names(dat)[1]
names(dat)[1] <- "subject"
dat

# but in large datasets, counting variable names to figure out the position of
# the variable that you want to rename would be very tedious

names(dat)
names(dat) == "age"
names(dat)[names(dat) == "age"] <- "years"
dat

# remove a variable from a data frame

dat
dat$y <- NULL
dat

# generate a new variable based on an existing one

dat
dat$days <- dat$years * 365
dat

# sum/mean of several variables

dat$y1 <- c(2, 4, 3)
dat$y2 <- c(5, 5, 1)
dat

dat$ysum  <- dat$y1 + dat$y2
dat$ymean <- (dat$y1 + dat$y2) / 2
dat

# there are special functions for this

dat$ysum  <- NULL
dat$ymean <- NULL
dat

dat[c("y1","y2")]
rowSums(dat[c("y1","y2")])
rowMeans(dat[c("y1","y2")])

dat$ysum  <- rowSums(dat[c("y1","y2")])
dat$ymean <- rowMeans(dat[c("y1","y2")])
dat

# what if there are missing values?

dat$y1[2] <- NA
dat

# then the resulting mean/sum will also be NA

dat$ysum  <- rowSums(dat[c("y1","y2")])
dat$ymean <- rowMeans(dat[c("y1","y2")])
dat

# can avoid this with the 'na.rm' argument (set it to TRUE); then the mean or
# sum is taken over the non-missing values within each row

dat$ysum  <- rowSums(dat[c("y1","y2")], na.rm=TRUE)
dat$ymean <- rowMeans(dat[c("y1","y2")], na.rm=TRUE)
dat

# subsetting when there are missing values

dat
dat$y1 >= 2
dat[dat$y1 >= 2,] # not good :(

# easier

dat$y1 >= 2
which(dat$y1 >= 2)
dat[which(dat$y1 >= 2),]

# easiest

subset(dat, y1 >= 2)

############################################################################

# quick summary of the bracket notation:
#
# say 'x' is a vector (could also be something like dat$x), then we can use []
# to select one or multiple elements from that vector (e.g., x[2] or x[1:3])
#
# say 'dat' is a data frame, then we can use:
# - dat[] to select one or more columns (e.g., dat[3] or dat["age"])
# - dat[row(s),column(s)] to select one or more rows and one or more columns
#   (e.g., dat[1:3,3] or dat[1:3,"age"])
# - when leaving out row(s) or column(s), then this means to select all rows
#   or columns (e.g., dat[1:3,] or dat[,"age"])
#
# often we use 'logicals' for selection/subsetting (e.g., dat[dat$age > 21,])

############################################################################

# a few other object types

# matrices: similar to data frames (i.e., have rows and columns), but all
# elements in a matrix must be of the same type (numeric, character, etc.)

# arrays: similar to matrices but can have more than two dimensions

# lists: a collection of objects (components); a list allows you to gather a
# variety of (possibly unrelated) objects under one name

# example of a list with 4 components

w <- list(name="Fred", age=24, grades=c(7,8,6,9,5,6),
          address=c("14 Pine Ave, Nicetown", "104 South Street, Bad City"))
w

# note: data frames are really just a special case of lists, where each
# component is of the same length

# factors: a special data type for nominal variables

gender <- c("Male","Male","Male","Male","Female","Male","Male","Female","Male")
gender
gender <- factor(gender)
gender

# internally, factors are stored as integers that are mapped to the levels
# (here: 1 = Female, 2 = Male)

# R now treats gender as a nominal variable

summary(gender) 

############################################################################
