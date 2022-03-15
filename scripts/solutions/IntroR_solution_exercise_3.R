#-----------------------------------------------------------------------------------------------------#
# 							GENERAL INFORMATION
#-----------------------------------------------------------------------------------------------------#
# File description:
#	Name
#		IntroR_solution_exercise_3.R
#
#	Purpose 
#		This code was made as a solution of "Exercise 3" in the 'Introduction to R' course (PSY4373). 
#		Additional questions or comments can be directed to the course coordinator, Ehsan Pishva (e.pishva@maastrichtuniversity.nl).
#		Exercise 3 can be found on https://ehsanpishva.github.io/IntroR-PSY4373/w3e.html
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
#- Test whether the perceived stress level differ between the primary sources of stress
#- Test if the impact of the stress sources on stress level is dependent on sex
#- Create a boxplot illustrating the comparison tested in Q3




#Part B:
#- Test the association between the Pearlin Mastery Scale and the perceived stress level.
#- Adjust the association tested in Q1 for age and sex and education
#- Plot the association betwee the two variables and fit the regression coefficient line
#- Use plot() for the result object obtained form the above association, place them in a 2x2 layout and try to interpret the generated plots
#- Test the correlation between sub-items of Pearlin Mastery Scale (mastery1, mastery2,…) and report the regression coefficients and p values
#- Create a scatterplot matrix of the sub-items tested in Q4



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
# Test whether the perceived stress level differ between the primary sources of stress

	# First check what we need, Perceived Stress Scale -> variables pss1 – pss10
	# Scale is between 1 (never) and 5 (very oftern); items 4,5,7,8 need to be reverse scored.
	# Variable 'pss' is the total


	# primary sources of stress -> Demographic variable called 'stress'
	# A categorical variable, 1 = work, 2 = spouse/partner, 3 = friendships, 4 = children, 5 = family, 6 = health/illness, 7 = life in general, 8 = money/finances, 9 = lack of time
	
	# So test if stress level(pss) differs due to different sources (sources)
	# Put more simply, variation between groups (ANOVA)

# Lets look at it basically
boxplot(dat$pss~dat$source,las=2)
	# Observed pss differences in mean and variance throughout source

# Run an Analysis of variance (ANOVA)
# Check out https://en.wikipedia.org/wiki/Analysis_of_variance#Example, it makes more intuitive sense
aov_res = aov(pss ~ source, data=dat)
summary(aov_res)
	# Almost significant at p = 0.0588
	# Results also 18 missing values, removed during test
	# Residual standard error: 5.762898
	# aov_res$coefficients also indicates different contribution per source, indicative that sourcespouse/partner yields in higher pss values, while sourcelack of time decreases pss. These results can be observed in boxplot as well.
	# The Residual standard error is indicative of the average level of unexplained variance, thus, variance NOT explained by 'source'. 
	

# Test if the impact of the stress sources on stress level is dependent on sex
# 

# Run an Analysis of variance (ANOVA) with sex included
aov_res = aov(pss ~ source * sex, data=dat)
summary(aov_res)
	# It seems sex is significantly affecting pss at p = 0.00172.
	# Source remains almost significant at p = 0.05656
	# The interaction between sex and source is highly INsignificant (p = 0.96359), indicative of no interaction effects between source and sex.
	# Results also 18 missing values, removed during test
	# Residual standard error: 5.738956 (slightly lower!)
	# aov_res$coefficients indicates different contribution per source*sex, indicative that if male AND pss source is from friendships yields higher pss levels. However, being male decreases pss levels in general.

 
# Create a boxplot illustrating the comparison tested in Q3 (Q2)
# A boxplot with huge names needs some resizing the magins
par(mar=c(4,10,4,2))

# Make sure drawing ouside plot is disabled, as abline will go of the chart.
par(xpd=FALSE)

# Actual base boxplot
boxplot(pss ~ source * sex,data=dat,
	col=c(rep("pink",sum(!sapply(unique(dat$source),is.na))),rep("lightblue",sum(!sapply(unique(dat$source),is.na)))),	# lets color code by sex (coded in such a way it will find the amount of different sources without NA)
	las=1,	# Turn the labels else they become unreadable
	horizontal=TRUE, # else the names really get messy
	xlab = "Perceived Stress Scale", 
	ylab = "", # Y label is replaced by "", this removes the label
	main = "PSS by group (sex and source)" # Main title
)

# Lets make it clear the sex difference is a thing by adding 2 (vertical) lines, mean male and mean female
Mean_male = mean(dat$pss[dat$sex=="male"],na.rm = TRUE) # Notice i removed the NAs by adding na.rm = TRUE
abline(v=Mean_male,col="lightblue3",lwd=3,lty=2)
Mean_female = mean(dat$pss[dat$sex=="female"],na.rm = TRUE)
abline(v=Mean_female,col="pink3",lwd=3,lty=2)

# Enable drawing outside plot, so legend is out of the way
par(xpd=TRUE)

# add legend
legend( x=-6,y=20, title="Mean",
   legend = c("Male","Female"), col=c("lightblue3","pink3"), lty = c(2, 2), horiz=T,lwd=2, cex=0.7)
   
# Disable drawing outside plot again
par(xpd=FALSE)



#-----------------------------------------------------------------------------------------------------#
#							Part B
#-----------------------------------------------------------------------------------------------------#
# Test the association between the Pearlin Mastery Scale and the perceived stress level.
# pss and mastery1
# 'mastery' is continuous variable as the sum of all the individual mastery elements. Each mastery element is a categorical vatiable which ranges 1 (strongly disagree) to 4 (strongly agree), elements 1,3,4,6,7 need to be reversely scored.
# This is not the same as before, because a continuous variable (pss) is now evaluated with a continuous variable (mastery).

# quick look at boxplot
boxplot(pss ~ mastery, data=dat)
	# Ah, higher mastery roughly translates to less pss, should indicate a rather strong negative correlation (as the trend is downward).

# Run a correlation test
cor_res = cor.test(dat$pss, dat$mastery)
cor_res
	# Significant correlation with p = < 2.2e-16
	# Correlation: -0.61344

# Run a linear model (format) in preparation of next question
lm_res <- lm(pss ~ mastery, data=dat)
summary(lm_res)

# Adjust the association tested in Q1 for age and sex and education
lm_res <- lm(pss ~ mastery + age + sex + educ, data=dat)
summary(lm_res)
	# It seems mastery, age and intercept are significant.
	# Sexmale is almost significant
	# 3 missing values and thus deleted
	# Adjusted R-squared:  0.3956
	# Residual standard error: 4.547

# Plot the association between the two variables and fit the regression coefficient line
plot(y=dat$pss, x= dat$mastery)

# create mastery line
x=1:40
mastery_line = lm_res$coefficients["(Intercept)"]+ x*lm_res$coefficients["mastery"]
lines(mastery_line, lwd=3, col="blue")


# Use plot() for the result object obtained form the above association, place them in a 2x2 layout and try to interpret the generated plots
par(mfrow=c(2,2)) 
plot(lm_res)
	# Left top plot: Indicates the remaining variation NOT explained by the model. If clearly some structure can be seen here, then the model can be used to account for that variation as well, if measured. In this case it seems like it is NOT structurally deviating, which is good.  
	# Left bottom plot: Similar to the left top ploy, yet more robust due to diminishment of skewness. Should be normally distributed, looks like it is (as the red line indicates the mean and is not shifting a lot).
	# Right top plot: QQ plot; Indicative of how residuals are distributed, if the model correctly models the intended effect, then the residuals should be normally distributed. Thus, the QQ plot should indicate identical 'real' quantiles compared to the 'theoretical' quantiles. In this case it seems OK, little deflation at the lower end, and slight inflation at upper end. 
	# Right bottom plot: This plot indicates how 'alike' the samples are in terms of residuals. Ideally this plot indicates low leverage for all samples. Google the word "heteroskedasticity". It assess the variation of residuals due to variation of variables of interest. It seems 2 samples are quite off, the rest seems to have low leverage (which is good)
	par(mfrow=c(1,1)) 
# Test the correlation between sub-items of Pearlin Mastery Scale (mastery1, mastery2,…) and report the regression coefficients and p values
# The cor.test function in R does not allow multiple sub-items to be tested. Quick google seach indicates many options, see https://stackoverflow.com/questions/5446426/calculate-correlation-for-more-than-two-variables. 

# First method uses rcorr from Hmisc package, indicates correlations and p-values.
# Lets make take the data of interest
data_cor = data.frame(m1=dat$mastery1,m2=dat$mastery2,m3=dat$mastery3,m4=dat$mastery4,m5=dat$mastery5,m6=dat$mastery6,m7=dat$mastery7)

# install.packages("Hmisc")
# Spearman as these are categorical features
res_cor = Hmisc::rcorr(as.matrix(data_cor),type = "spearman")

# Correlations:
res_cor$r

# P-values:
res_cor$P

# Create a scatterplot matrix of the sub-items tested in Q4
# To create a scatterplot between X and Y its plot(X,Y)
# However if X happens to contain more than 1 feature, it will (try to) deal with it
# if you put all data into 1 dataframe and plot it, it will show multiple scatterplot for all features in your data.
# The data has been defined before (data_cor) so plotting it by plot.
plot(data_cor)

# Yes it seems like it doensnt make sense, however, think about it. These are questioneers dedicated to measure self-concept and references the extent to which individuals perceive themselves in control of forces that significantly impact their lives. 

# What would it mean if all these questions correlate very well? Then asking more than one or 2 questions is not needed, because you capture the same information for all questions. 

# Thus, this plot might indicate all questions are diverse enough and hold unique information per question.