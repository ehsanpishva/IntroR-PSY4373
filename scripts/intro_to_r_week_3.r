############################################################################

# restart the R session (Menu 'Session' - 'Restart R')

# read in data

load("data_survey_edit.rdata")

############################################################################

# t-test

t.test(pss ~ sex, data=dat)

# note: this runs a t-test *not* assuming equal variances in the two groups
# (known as Welch's t-test): https://en.wikipedia.org/wiki/Welch's_t-test

# t-test assuming equal variances in the two groups (Student's t-test)

t.test(pss ~ sex, data=dat, var.equal=TRUE)

# visualize densities of the two groups

res.m <- density(dat$pss[dat$sex == "male"], na.rm = TRUE)
res.f <- density(dat$pss[dat$sex == "female"], na.rm = TRUE)

plot(res.m, xlab="Perceived Stress Scale Value", main="Kernel Density Estimates of Stress for Males and Females")
polygon(res.m, col=rgb(0,0,1,.2))
lines(res.f)
polygon(res.f, col=rgb(1,0,0,.2))
legend("topright", inset=.02, legend=c("Males", "Females"), fill=c(rgb(0,0,1,.2), rgb(1,0,0,.2)))

# try with a grouping variable that has more than 2 levels (error!)

t.test(pss ~ marital, data=dat)

############################################################################

# one-way ANOVA
# https://en.wikipedia.org/wiki/One-way_analysis_of_variance

res <- aov(pss ~ marital, data=dat)
res
summary(res)

# the F-test is a test of the null hypothesis that the true PSS means of the 8
# different marital status groups are identical (which we reject here, p < .01)

# difference between means for all pairs of levels
# https://en.wikipedia.org/wiki/Tukey's_range_test

sav <- TukeyHSD(res)
sav

# provides tests of the difference between each pair of levels of the grouping
# variable (adjusted for multiple testing)

# CIs for the difference in mean levels

par(mar=c(5,16,4,2))
plot(sav, las=1)

dev.off()

############################################################################

# boxplot with two variables

boxplot(pss ~ sex * marital, data=dat, col="lightgray")

boxplot(pss ~ sex * marital, data=dat, col="lightgray", horizontal=TRUE)

par(mar=c(5,13,4,2))

boxplot(pss ~ sex * marital, data=dat, col="lightgray",
        xlab="PSS", ylab="", pch=19, horizontal=TRUE, las=1)

boxplot(pss ~ sex * marital, data=dat, col=rep(rainbow(8,alpha=0.4), each=2),
        xlab="PSS", ylab="", pch=19, horizontal=TRUE, las=1)

dev.off()

############################################################################

# two-way ANOVA with interaction
# https://en.wikipedia.org/wiki/Two-way_analysis_of_variance

res <- aov(pss ~ sex * marital, data=dat)
summary(res)

# two-way ANOVA with main effects only

res <- aov(pss ~ sex + marital, data=dat)
summary(res)

TukeyHSD(res)

# note: R (by default) computes Type I Sum of Squares (sequential tests), so
# the order how you specify the factors matters (while many other statistical
# software packages compute Type III Sum of Squares)

res <- aov(pss ~ marital + sex, data=dat)
summary(res)

############################################################################

# note: one can also fit more complex ANOVA models (including models with
# within-subjects / repeated-measures factors and a mix of between- and
# within-subject factors) with the aov() function, but we won't cover this
#
# some examples can be found here:
# https://stats.oarc.ucla.edu/r/seminars/repeated-measures-analysis-with-r/
#
# see also the ezANOVA() function from the 'ez' package that might be easier
# to use for complex ANOVA models (https://cran.r-project.org/package=ez)

############################################################################

# correlations
# https://en.wikipedia.org/wiki/Pearson_correlation_coefficient

# between two variables

cor(dat$posaff, dat$negaff)

# correlation testing

cor.test(dat$posaff, dat$negaff)

# Spearman correlation
# https://en.wikipedia.org/wiki/Spearman's_rank_correlation_coefficient

cor(dat$posaff, dat$negaff, method="spearman")

############################################################################

# linear regression
# https://en.wikipedia.org/wiki/Linear_regression

# scatterplot of age (x-axis) versus stress (y-axis)

plot(dat$age, dat$pss, pch=19)

# can also use 'formula syntax'

plot(pss ~ age, data=dat, pch=19)

# simple regression of stress (outcome) on age (predictor)

res <- lm(pss ~ age, data=dat)
res
summary(res)

# add regression line to the plot above (lwd is for the line width)

abline(res, lwd=3, col="red")

# fitted values, residuals, standardized residuals

fitted(res)
residuals(res)
rstandard(res)

# fitted values versus standardized residuals plot

plot(fitted(res), rstandard(res), pch=19,
     xlab="Fitted Values", ylab="Residuals")
abline(h=0)

# histogram of the standardized residuals

hist(rstandard(res))

# normal Q-Q plot of the standardized residuals
# https://en.wikipedia.org/wiki/Q-Q_plot

qqnorm(rstandard(res), pch=19)
qqline(rstandard(res))

# plot of the Cook's distances
# https://en.wikipedia.org/wiki/Cook's_distance

plot(cooks.distance(res), pch=19, type="o", ylab="Cook's Distance")

# identify the potentially influential subjects

abline(h=0.03)
which(cooks.distance(res) > 0.03)

plot(pss ~ age, data=dat, pch=19)
abline(res, lwd=3)
points(pss ~ age, data=dat, subset=c(68,77), col="red", pch=19, cex=2)

# fit model without subjects 68 and 77

tmp <- lm(pss ~ age, data=dat, subset=-c(68,77))
summary(tmp)

# just to illustrate an extreme case

tmp <- dat
tmp$age[235] <- 80
tmp$pss[235] <- 45

plot(pss ~ age, data=tmp, pch=19)
res <- lm(pss ~ age, data=tmp)
abline(res, lwd=3)

plot(cooks.distance(res), pch=19, type="o", ylab="Cook's Distance")

############################################################################

# digression: Type III tests with the 'car' package

# install (if necessary) and load the 'car' package

if (!suppressWarnings(require(car))) install.packages("car")

library(car)

res <- aov(pss ~ sex + marital, data=dat)

# sequential tests

summary(res)

# get the marginal tests (Anova() function comes from the 'car' package)

Anova(res, type=3)

# to compare

summary(aov(pss ~ sex + marital, data=dat))
summary(aov(pss ~ marital + sex, data=dat))

############################################################################

# refit the regression model

res <- lm(pss ~ age, data=dat)
summary(res)

plot(pss ~ age, data=dat, pch=19)

coef(res)

# computing predicted values

# the manual way: adding a line based on the predicted values

xvals <- 10:90
xvals
yvals <- coef(res)[1] + coef(res)[2] * xvals
yvals

lines(xvals, yvals, lwd=3, col="red")

# using the predict() function

# first create a data frame with the same predictor(s) as used in the model

newdat <- data.frame(age = 10:90)

# now can use the predict() function with 'newdata'

predict(res, newdata=newdat)

# this is useful because predict() can also give us additional information

predict(res, newdata=newdat, interval="confidence")

# save this to an object

pred <- predict(res, newdata=newdat, interval="confidence")
head(pred)

# now add the line to the plot

plot(pss ~ age, data=dat, pch=19)
lines(newdat$age, pred$fit, lwd=3)

# what?!? (error messages in R are sometimes super informative ...)

# predict() doesn't return a data frame, but a matrix (which is similar to a
# data frame, but a matrix cannot contain a mix of numerical and character
# variables and one cannot use the $ notation to extract elements)

# this works

pred[,"fit"]

# or we can turn the matrix into a data frame

pred <- as.data.frame(pred)
head(pred)

# now this works (lty is for the line type)

lines(newdat$age, pred$fit, lwd=3, col="red")
lines(newdat$age, pred$lwr, lty="dashed", col="red")
lines(newdat$age, pred$upr, lty="dashed", col="red")

# also add the prediction interval

pred <- predict(res, newdata=newdat, interval="prediction")
pred <- as.data.frame(pred)

lines(newdat$age, pred$lwr, lty="dotted", col="blue")
lines(newdat$age, pred$upr, lty="dotted", col="blue")

# https://en.wikipedia.org/wiki/Prediction_interval#Regression_analysis

############################################################################

# polynomial regression
# https://en.wikipedia.org/wiki/Polynomial_regression

set.seed(1234)
plot(jitter(dat$negaff, amount=.5), jitter(dat$pss, amount=.5), pch=19,
     xlab="Negative Affect", ylab="Perceived Stress", cex=0.5)

res <- lm(pss ~ negaff, data=dat)
summary(res)

abline(res, lwd=3)

res <- lm(pss ~ negaff + I(negaff^2), data=dat)
summary(res)

# the manual way

xvals <- 0:50
xvals
yvals <- coef(res)[1] + coef(res)[2] * xvals + coef(res)[3] * xvals^2
yvals

lines(xvals, yvals, col="red", lwd=3)

# using predict()

newdat <- data.frame(negaff = 0:50)
predict(res, newdata=newdat)

# note: the predict() function applies the same transformations we used when
# we specified the model

pred <- predict(res, newdata=newdat)
lines(newdat$negaff, pred, col="green", lwd=3)

############################################################################

# multiple regression

res <- lm(pss ~ age + rses, data=dat)
summary(res)

res <- lm(pss ~ age + rses + age:rses, data=dat)
summary(res)

res <- lm(pss ~ age * rses, data=dat)
summary(res)

# note: var1 * var2 is a shortcut for adding the main effects of var1 and var2
# and also their interaction (i.e., var1:var2)

############################################################################

# categorical predictors

res <- lm(pss ~ sex, data=dat)
summary(res)

res <- lm(pss ~ marital, data=dat)
summary(res)

# variables 'sex' and 'marital' are character variables

dat$marital

# character variables are turned into 'factors' when used as predictors; and
# factors are 'dummy coded' when used as predictors; the first level of a
# factor is (by default) the one that comes first alphanumerically

# we can manually turn a variable into a factor

factor(dat$marital)

# the first level is the 'reference' level (in this case 'divorced'); the
# intercept corresponds to the mean PSS value of this reference group

mean(dat$pss[dat$marital == "divorced"])

# the coefficients for the other groups are the *difference* between the means
# of these groups and the mean of the reference group

mean(dat$pss[dat$marital == "separated"]) - mean(dat$pss[dat$marital == "divorced"])

# we can 'relevel' a factor to choose the reference level

relevel(factor(dat$marital), ref="single")

# as always, need to back-assign to make this change permanent

dat$marital <- relevel(factor(dat$marital), ref="single")

# check levels of factor variable

levels(dat$marital)

res <- lm(pss ~ marital, data=dat)
summary(res)

############################################################################

# categorical and numerical predictors in the same model

res <- lm(pss ~ sex + negaff, data=dat)
summary(res)

# note: this is the same as an analysis of covariance (ANCOVA)
# https://en.wikipedia.org/wiki/Analysis_of_covariance

# with interaction

res <- lm(pss ~ sex * negaff, data=dat)
summary(res)

# plot results

set.seed(9876)
plot(jitter(pss, amount=0.5) ~ jitter(negaff, amount=0.5), data=dat,
     xlab="Negative Affect", ylab="Stress",
     main="Relationship Between Stress and Negative Affect",
     pch=19, xlim=c(10,50), ylim=c(10,50),
     col=ifelse(dat$sex == "female", "red", "blue"), cex=0.5)

# using predict() to add regression line for the males and females

range(dat$negaff)

newdat <- data.frame(sex = "male", negaff=0:50)
newdat
pred <- predict(res, newdata=newdat)
pred

lines(newdat$negaff, pred, lwd=3, col="blue")

newdat <- data.frame(sex = "female", negaff=0:50)
pred <- predict(res, newdata=newdat)

lines(newdat$negaff, pred, lwd=3, col="red")

# add a legend

legend("topleft", legend=c("female","male"), col=c("red","blue"),
       pch=c(19,19), lty=c("solid","solid"), inset=.02)

############################################################################

# smoothers

set.seed(4321)
plot(jitter(dat$negaff, amount=.5), jitter(dat$pss, amount=.5), pch=19,
     xlab="Negative Affect", ylab="Perceived Stress", cex=0.5)

res <- lm(pss ~ negaff + I(negaff^2), data=dat)
summary(res)

newdat <- data.frame(negaff = 0:50)
pred <- predict(res, newdata=newdat)
lines(newdat$negaff, pred, col="red", lwd=3)

# loess = locally estimated scatterplot smoothing
# - provides a non-parametric estimate of the relationship between x and y
# - https://en.wikipedia.org/wiki/Local_regression

res <- loess(pss ~ negaff, data=dat)
summary(res)

pred <- predict(res, newdata=newdat)
lines(newdat$negaff, pred, col="blue", lwd=3)

# adjust the 'span' argument (default is 0.75; lower means less smoothing)

res <- loess(pss ~ negaff, data=dat, span=0.4)
pred <- predict(res, newdata=newdat)
lines(newdat$negaff, pred, col="green", lwd=3)

legend("bottomright", inset=.02, col=c("red","blue","green"),
       legend=c("2nd Degree Polynomial","Smoother (span = 0.75)","Smoother (span = 0.40)"),
       lty="solid", lwd=3, cex=0.8)

############################################################################
