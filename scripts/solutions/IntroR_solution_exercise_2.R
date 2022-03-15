#-----------------------------------------------------------------------------------------------------#
# 							GENERAL INFORMATION
#-----------------------------------------------------------------------------------------------------#
# File description:
#	Name
#		IntroR_solution_exercise_2.R
#
#	Purpose 
#		This code was made as a solution of "Exercise 2" in the 'Introduction to R' course (PSY4373). 
#		Additional questions or comments can be directed to the course coordinator, Ehsan Pishva (e.pishva@maastrichtuniversity.nl).
#		Exercise 2 can be found on https://ehsanpishva.github.io/IntroR-PSY4373/w2e.html
#
# Author comment:
#	Rick Reijnders
#	ra.reijnders@maastrichtuniversity.nl
#


#-----------------------------------------------------------------------------------------------------#
#							Exercise description
#-----------------------------------------------------------------------------------------------------#
# These variables all use the data frame (“data_survey_edit.rdata”). A data dictionary is provided to describe the variables in the dataset.

#Part A:
#- Create a boxplot showing Positive affect by marital status.
#- Modify the x-axis text.
#- Change the range of values in y axis.
#- Modify the labels for x an y axes.
#- Give different colors to each marital state.
#- Add jitter to the boxplot (https://www.r-graph-gallery.com/96-boxplot-with-jitter.html).
#- Add a legend and insert it at topleft (make sure doesnt overly your plots).



#Part B:
#- Make a scatterplot showing the association between the Rosenberg Self-Esteem Scale (Total) and Negative affect.
#- Modify the x-axis text.
#- Change the range of values in y axis.
#- Modify the labels for x an y axes.
#- Color label the points based on sex.
#- Use different synboles for male and female.
#- Add a correlation coeffcient line to the scatter plot.
#- Add a legend and insert it at bottomleft (make sure doesnt overly your plots).



#-----------------------------------------------------------------------------------------------------#
#							Loading data
#-----------------------------------------------------------------------------------------------------#

# First set the directory to where the downloaded files are located
setwd("C:/Users/p70072451/Downloads")

# This is also correct:
# setwd("C:\\Users\\p70072451\\Downloads") 

# As the file is a Rdata file, use load() to load the environment. This is not a single dataset, but can contain more objects which can be explored in the 'environment' tab. This way is often used to share between R-users, however, this file can ONLY be opened in R.
load("data_survey_edit.rdata")

# Results in an object called 'dat'

#-----------------------------------------------------------------------------------------------------#
#							Part A
#-----------------------------------------------------------------------------------------------------#
# Create a boxplot showing Positive affect by marital status.

# First it is important to know where in the data the postive affect and marital status is.
# There are may methods to this, using view(dat), rownames(dat)/colnames(dat), exploring the data manually.
# Personally i tend to use colnames(dat)
# It results in:
#> colnames(dat)
# [1] "id"       "age"      "sex"      "marital"  "children" "educ"     "source"   "smoke"   
# [9] "smokenum" "lotr1"    "lotr2"    "lotr3"    "lotr4"    "lotr5"    "lotr6"    "mastery1"
#[17] "mastery2" "mastery3" "mastery4" "mastery5" "mastery6" "mastery7" "panas1"   "panas2"  
#[25] "panas3"   "panas4"   "panas5"   "panas6"   "panas7"   "panas8"   "panas9"   "panas10" 
#[33] "panas11"  "panas12"  "panas13"  "panas14"  "panas15"  "panas16"  "panas17"  "panas18" 
#[41] "panas19"  "panas20"  "swls1"    "swls2"    "swls3"    "swls4"    "swls5"    "pss1"    
#[49] "pss2"     "pss3"     "pss4"     "pss5"     "pss6"     "pss7"     "pss8"     "pss9"    
#[57] "pss10"    "rses1"    "rses2"    "rses3"    "rses4"    "rses5"    "rses6"    "rses7"   
#[65] "rses8"    "rses9"    "rses10"   "lotr"     "mastery"  "pss"      "rses"     "posaff"  
#[73] "negaff"  

# This is indicative the "marital" and "posaff" might be the features of interest. These are confirmed by the data dictionary (pdf).

# Simple boxplot of posaff by marital
boxplot(dat$posaff~dat$marital)

# It isnt that pretty, lets make it more aesthetically appealing by upcoming steps
# Modify the x-axis text
boxplot(dat$posaff~dat$marital,las=2)

# Change the range of values in y axis.
boxplot(dat$posaff~dat$marital,las=2,ylim=c(10,60))

# Modify the labels for x an y axes.
boxplot(dat$posaff~dat$marital,las=2,ylim=c(10,60),xlab="Marital Status", ylab="Positive affect")

# Give different colors to each marital state.
boxplot(dat$posaff~dat$marital,las=2,ylim=c(10,60),xlab="Marital Status", ylab="Positive affect",col=rainbow(8))

# Add jitter to the boxplot (https://www.r-graph-gallery.com/96-boxplot-with-jitter.html).
boxplot(dat$posaff~dat$marital,las=2,ylim=c(10,60),xlab="Marital Status", ylab="Positive affect",col=rainbow(8))

mylevels <- levels(as.factor(dat$marital))
levelProportions <- summary(as.factor(dat$marital))/nrow(dat)
for(i in 1:length(mylevels)){
 
  thislevel <- mylevels[i]
  thisvalues <- dat[as.factor(dat$marital)==thislevel, "posaff"]
   
  # take the x-axis indices and add a jitter, proportional to the N in each level
  myjitter <- jitter(rep(i, length(thisvalues)), amount=levelProportions[i]/2)
  points(myjitter, thisvalues, pch=20, col=rgb(0,0,0,.9)) 
   
}


# Add a legend and insert it at topleft (make sure doesnt overly your plots).
par(mar=c(15,4,4,2))
legend("topleft", inset=.02, title="Marital Status",
   c(levels(as.factor(dat$marital))), fill=rainbow(8), horiz=F, cex=0.6)
   
# This boxplot needs a large image size to render successfully (this maybe requires setting the 'Plot viewer' to a larger size (by dragging the edges).


#-----------------------------------------------------------------------------------------------------#
#							Part B
#-----------------------------------------------------------------------------------------------------#
# Make a scatterplot showing the association between the Rosenberg Self-Esteem Scale (Total) and Negative affect.
plot(dat$negaff~dat$rses)


# Modify the x-axis text. This is not helping the image, leaving it as is.
# plot(dat$rses,dat$negaff)

# Change the range of values in y axis.
plot(dat$negaff~dat$rses,ylim=c(0,50))

# Modify the labels for x an y axes.
plot(dat$negaff~dat$rses,ylim=c(0,50),xlab="Rosenberg Self-Esteem Scale (Total)",ylab="Negative affect")

# Color label the points based on sex.
plot(dat$negaff~dat$rses,ylim=c(0,50),xlab="Rosenberg Self-Esteem Scale (Total)",ylab="Negative affect",col=dat$sex)

# Use different synboles for male and female.
cols = ifelse(dat$sex=="female","blue","red")
symbs =  ifelse(dat$sex=="female",0,1)
plot(dat$negaff~dat$rses,ylim=c(0,50),xlab="Rosenberg Self-Esteem Scale (Total)",ylab="Negative affect",col=cols,pch=symbs)

# Add a correlation coeffcient line to the scatter plot. 
abline(lm(dat$negaff~dat$rses), col="Black",lty=2,lwd=2) # regression line (y~x)


# Add a legend and insert it at bottomleft (make sure doesnt overly your plots).
par(mar=c(5,4,4,2))
legend("topleft", inset=.02, title="Sex",
   c("Female","Male"), col=c("Blue","Red"),pch=c(0,1), horiz=F, cex=0.8)
